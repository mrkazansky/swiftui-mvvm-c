//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Combine
import Networking

public class FakeEventListNetworkService: EventListService {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func fetchEvents(page: Int) -> AnyPublisher<EventResponse, Error> {
        let resourceName = "user_stories_\(min(page, 3))"
        if let url = Bundle.module.url(forResource: resourceName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(EventResponse.self, from: data)
                return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
            } catch let error {
                return Fail(error: error).eraseToAnyPublisher()
            }
        } else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
    }
}
