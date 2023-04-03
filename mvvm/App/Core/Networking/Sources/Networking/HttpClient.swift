//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Combine

struct API {
    static let baseURL : URL = URL(string: "http://stg.api.com")!
}

public enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
}

public protocol HTTPClient {
    func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkingResponse<T>, Error>
}

public struct URLSessionClient: HTTPClient {
    public init() {}
    
    public func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkingResponse<T>, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap{result -> NetworkingResponse<T> in
                let item: T = try JSONDecoder().decode(T.self, from: result.data)
                return NetworkingResponse(value: item, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
