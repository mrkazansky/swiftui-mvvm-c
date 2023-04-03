//
//  EvenListUseCaseTest.swift
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

final class EvenListUseCaseTest: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var useCase: EventListUseCase!
    var mockService: EventListService!
    
    override func tearDown() {
        cancellables.removeAll()
        useCase = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_return_correct_when_fetch_events() {
        //Arrange
        mockService = MockHappyCaseEventListNetworkService()
        useCase = EventListUseCase(networkService: mockService)
    
        var receivedEvents: [(Date, [EventEntity.EventModel])]?
        var receivedError: Error?
        let expectation = XCTestExpectation(description: "Fetch events completed")
        let expectedEventCount = 1
        //Assign
        useCase.fetchEvents(page: 0)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { value in
                receivedEvents = value
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        //Assert
        XCTAssertNil(receivedError)
        XCTAssertEqual(expectedEventCount, receivedEvents?.count)
    }
    
    func test_return_error_when_fetch_events() {
        //Arrange
        mockService = MockFailCaseEventListNetworkService()
        useCase = EventListUseCase(networkService: mockService)
    
        let expectedError = NetworkError.unknown
        var receivedEvents: [(Date, [EventEntity.EventModel])]?
        var receivedError: Error?
        let expectation = XCTestExpectation(description: "Fetch events completed")
        //Assign
        useCase.fetchEvents(page: 0)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { value in
                receivedEvents = value
            }
            .store(in: &cancellables)        
        wait(for: [expectation], timeout: 1.0)
        //Assert
        XCTAssertNil(receivedEvents)
        XCTAssertEqual(expectedError.localizedDescription, receivedError?.localizedDescription)
    }
}
