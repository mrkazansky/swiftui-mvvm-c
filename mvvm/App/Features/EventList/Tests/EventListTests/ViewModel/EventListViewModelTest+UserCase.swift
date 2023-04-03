//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
import Networking
import Model
@testable import EventList

class EventListViewModelUseCaseTest: XCTestCase {
    private var usecase : EventListUseCaseProtocol!
    private let mockService = MockHappyCaseEventListNetworkService()
    internal let coordinator = MockCoordinator()
    internal var viewModel: EventListViewModel!
    
    override func tearDown() {
        viewModel = nil
        usecase = nil
    }
    
    func test_return_error_for_fetch_events(){
        //Arrange
        usecase = MockFailedEventListUsecase()
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
        let expectedValue = NetworkError.unknown.localizedDescription
        viewModel.fetchEvents()
        //Assign
        let actualValue = viewModel.error?.localizedDescription
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_for_fetch_events(){
        //Arrange
        usecase = MockHappyEventListUsecase(mockService: mockService)
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
        let expectedValue = 1
        viewModel.fetchEvents()
        //Assign
        let actualValue = viewModel.events.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_for_merge_events() {
        //Arrange
        usecase = MockHappyEventListUsecase(mockService: mockService)
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
        let expectedValue = 2
        let expectedTotalCountValue = mockService.limit * 2
        let eventsFirst = Dictionary(grouping: mockService.firstResponse.data.userTimeline, by: {
            $0.eventDate.toDate(TimeFormat.isoSimple)?.startOfDay ?? Date()
        }).sorted { $0.key > $1.key }
        let eventsSecond = Dictionary(grouping: mockService.secondResponse.data.userTimeline, by: {
            $0.eventDate.toDate(TimeFormat.isoSimple)?.startOfDay ?? Date()
        }).sorted { $0.key > $1.key }
        
        //Assign
        let result = viewModel.mergeEvents(eventsFirst, eventsSecond)
        let actual = result.count
        let actualTotalCount = result.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(actual, expectedValue)
        XCTAssertEqual(actualTotalCount, expectedTotalCountValue)
    }
    
}
