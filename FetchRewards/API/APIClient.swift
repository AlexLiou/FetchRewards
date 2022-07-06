//
//  APIClient.swift
//  FetchRewards
//
//  Created by Alex Liou on 7/4/22.
//

import Foundation

enum APIError<T>: Error {
    case badURL(String)
    case decode(Error)
    case response(T, code: Int)
    case cancelled
    case generic(Error?)

    var localizedDescription: String {
        switch self {
        case .badURL(let url):
            return "The url \(url) was invalid."
        case .decode(let error):
            return "Decode Error: \(error.localizedDescription)"
        case .response(let error, _):
            return "API call response: \(error)"
        case .cancelled:
            return "API call cancelled"
        case .generic(let error):
            return "Generic Error: \(String(describing: error))"
        }
    }
}

protocol APIClient {
    func send<T: APIRequest>(
        request: T,
        completion: @escaping (Result<T.SuccessResponse, APIError<T.FailureResponse>>
    ) -> Void)

    func send<T>(request: T) async throws -> T.SuccessResponse where T: APIRequest
}
