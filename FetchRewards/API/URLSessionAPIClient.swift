//
//  URLSessionAPIClient.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import Foundation

class URLSessionAPIClient: APIClient {
    //Pass in URLSession so that we can mock it for tests
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func send<T>(request: T) async throws -> T.SuccessResponse where T: APIRequest {
        let url = request.baseURL
        let (data, response) = try await URLSession.shared.data(from: URL(string: url)!)
        return try JSONDecoder().decode(T.SuccessResponse.self, from: data)
    }

    func send<T>(
        request: T,
        completion: @escaping (Result<T.SuccessResponse, APIError<T.FailureResponse>>) -> Void
    ) where T: APIRequest {
        guard let urlRequest = self.urlRequest(for: request) else {
            DispatchQueue.main.async {
                completion(.failure(APIError<T.FailureResponse>.badURL(request.fullURL)))
            }
            return
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            var completionError: Error?
            let httpResponseCode = (response as? HTTPURLResponse)?.statusCode ?? 200

            if let data = data {
                //If the status code is outside the success spectrum ie 200 -> 399 decode to failure
                guard 200 ..< 400 ~= httpResponseCode else {
                    DispatchQueue.main.async {
                        completion(.failure(self.decodeFailureResponse(
                            request: request,
                            data: data,
                            code: httpResponseCode
                        )))
                    }
                    return
                }
                //If status code in success spectrum decode the response object
                DispatchQueue.main.async {
                    completion(self.decodeSuccessResponse(request: request, data: data))
                }
                return
            } else if let error = error {
                if (error as NSError).code == NSURLErrorCancelled {
                    DispatchQueue.main.async {
                        completion(.failure(APIError<T.FailureResponse>.cancelled))
                    }
                    return
                }
                completionError = error
            }

            DispatchQueue.main.async {
                completion(.failure(APIError<T.FailureResponse>.generic(completionError)))
            }
        }
        task.resume()
    }

    private func decodeFailureResponse<T: APIRequest>(
        request: T,
        data: Data,
        code: Int
    ) -> APIError<T.FailureResponse> {
        //If type is AnyResponse we don't need to json decode
        if T.FailureResponse.self == AnyResponse.self, let anyResponse = AnyResponse(from: data) as? T.FailureResponse {
            return APIError.response(anyResponse, code: code)
        }
        do {
            let result = try JSONDecoder().decode(T.FailureResponse.self, from: data)
            return APIError.response(result, code: code)
        } catch let error {
            if let result =
                try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? T.FailureResponse {
                return APIError.response(result, code: code)
            }
            return APIError.decode(error)
        }
    }

    private func decodeSuccessResponse<T: APIRequest>(
        request: T, data: Data
    ) -> Result<T.SuccessResponse, APIError<T.FailureResponse>> {
        //If we can just convet to the target type for example like Data just do that
        if let data = data as? T.SuccessResponse { return .success(data) }
        //If type is AnyResponse we don't need to json decode
        if T.SuccessResponse.self == AnyResponse.self, let anyResponse = AnyResponse(from: data) as? T.SuccessResponse {
            return .success(anyResponse)
        }
        do {
            let result = try JSONDecoder().decode(T.SuccessResponse.self, from: data)
            return .success(result)
        } catch let error {
            return .failure(APIError.decode(error))
        }
    }

    private func urlRequest<T: APIRequest>(for resource: T) -> URLRequest? {
        guard
            let baseUrl = URL(string: resource.fullURL),
            var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        else {
            return nil
        }
        if let queryParameters = resource.queryParameters {
            urlComponents.queryItems = queryParameters.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        }
        // Construct the final URL with all the previous data
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = TimeInterval(resource.timeout)
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.httpShouldHandleCookies = false
        urlRequest.setValue(resource.headerContentType.rawValue, forHTTPHeaderField: "Content-Type")

        //Handle adding all the headers
        if let headers = resource.headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        // Handle diff uploadType
        if let bodyParams = resource.bodyParameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams)
            urlRequest.httpBody = jsonData
        }
        return urlRequest
    }
}
