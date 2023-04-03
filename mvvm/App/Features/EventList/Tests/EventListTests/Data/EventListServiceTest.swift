//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
import Foundation
import Combine
import Model
import Networking
@testable import EventList

class MockHttpClient: HTTPClient {
    public var isPerformCalled = false
    public func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<NetworkingResponse<T>, Error> {
        self.isPerformCalled = true
        return Just(NetworkingResponse(value: EventListResponse(data: EventListData(userTimeline: [])) as! T, response: .init())).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

final class EventListServiceTest: XCTestCase {
    
    var httpClient: MockHttpClient!
    var service: EventListService!
    
    override func setUp() {
        httpClient = MockHttpClient()
        service = EventListNetworkService(client: httpClient)
    }
    
    override func tearDown() {
        httpClient = nil
        service = nil
    }
    
    func test_client_perform_is_called(){
        XCTAssertFalse(httpClient.isPerformCalled)
        let _ = service.fetchEvents(page: 1)
        XCTAssertTrue(httpClient.isPerformCalled)
    }
}
