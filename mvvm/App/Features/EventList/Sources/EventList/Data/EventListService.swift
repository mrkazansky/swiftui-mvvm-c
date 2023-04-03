//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Combine
import Networking

public protocol EventListService {
    typealias EventResponse = EventListResponse
    
    func fetchEvents(page: Int) -> AnyPublisher<EventResponse, Error>
}

public struct EventListNetworkService: EventListService {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func fetchEvents(page: Int) -> AnyPublisher<EventResponse, Error> {
        let request = EventRequest().buildURLRequest()
        return client.perform(request)
            .map(\.value)            
            .eraseToAnyPublisher()
    }
}
