//
//  EventListViewModelTest.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import XCTest
@testable import EventList

class EventListViewModelHappyCaseTest: XCTestCase {
    private var usecase : EventListUseCase!
    internal let mockService = MockHappyCaseEventListNetworkService()
    internal let coordinator = MockCoordinator()
    internal var viewModel: EventListViewModel!


    override func setUp() {
        usecase = EventListUseCase(networkService: mockService)
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        usecase = nil
    }
}
