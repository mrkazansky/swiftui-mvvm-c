//
//  File.swift
//
//
//  Created by Bills on 01/04/2023.
//

import Combine
import Foundation

public struct NetworkingResponse<T> {
    public init(value: T, response: URLResponse) {
        self.value = value
        self.response = response
    }
    
    public let value: T
    let response: URLResponse
}

public protocol NetworkingRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryParams: [URLQueryItem]? { get }
    
    func buildURLRequest() -> URLRequest
}

public extension NetworkingRequest {
    var method: HTTPMethod { .GET }
    var body: Data? { nil }
    
    func buildURLRequest() -> URLRequest {
        let pathURL = API.baseURL.appendingPathComponent(path)
        var urlComponent = URLComponents(url: pathURL, resolvingAgainstBaseURL: false)
        if let params = queryParams {
            urlComponent?.queryItems = params
        }
        var urlRequest = URLRequest(url: (urlComponent?.url)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
