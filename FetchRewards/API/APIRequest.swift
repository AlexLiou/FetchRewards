//
//  APIRequest.swift
//  FetchRewards
//
//  Created by Alex Liou on 6/26/22.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum APIHeaderContentType {
    case json
    var rawValue: String {
        switch self {
        case .json:
            return "application/json"
        }
    }
}

protocol APIRequest {
    ///The success object we want to decode the json response to (If none set to AnyResponse)
    associatedtype SuccessResponse: Codable
    ///Any failure response where the api returns an actual json object (If none set to AnyResponse)
    associatedtype FailureResponse: Codable

    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: Any]? { get }
    var bodyParameters: [String: Any]? { get }
    var headerContentType: APIHeaderContentType { get }
    var headers: [String: String]? { get }
    var timeout: Int { get }
}


struct AnyResponse: Codable {
    let value: String
    init(from data: Data) {
        if
            JSONSerialization.isValidJSONObject(data),
            let json = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        {
            self.value = String(data: json, encoding: .utf8) ?? String(decoding: data, as: UTF8.self)
        } else {
            self.value = String(decoding: data, as: UTF8.self)
        }
    }
}

//The standard api error response envelope
struct ErrorResponse<T: Codable>: Codable {
    let error: T
}

extension APIRequest {
    var fullURL: String { baseURL + path }
    var queryParameters: [String: Any]? { return nil }
    var bodyParameters: [String: Any]? { return nil }
    var headerContentType: APIHeaderContentType { return .json }
    var headers: [String: String]? { return nil }
    var timeout: Int { return 30 }
}
