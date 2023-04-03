//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import XCTest
@testable import EventList

extension EventListViewModelHappyCaseTest {
    //Total count section
    func test_return_correct_event_count_initial_state() {
        //Arrange
        let expectedValue = 0
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_appear(){
        //Arrange
        let expectedValue = mockService.limit
        viewModel.viewDidLoad()
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_at_center_item(){
        //Arrange
        let expectedValue = mockService.limit
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit/2)
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_at_last_item_in_first_page(){
        //Arrange
        let expectedValue = mockService.limit * 2
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_at_center_item_in_second_page(){
        //Arrange
        let expectedValue = mockService.limit * 2
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit + mockService.limit/2)
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_at_last_item_in_second_page(){
        //Arrange
        let expectedValue = mockService.limit * 3
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit*2 - 1)
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_event_count_when_list_at_last_item_in_last_page(){
        //Arrange
        let expectedValue = mockService.limit * 3
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit*2 - 1)
        viewModel.onItemAppear(mockService.limit*3 - 1)
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    //Events section
    func test_return_correct_events_initial_state() {
        //Arrange
        let expectedValue = 0
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedValue, actualEventsValue)
    }
    
    func test_return_correct_events_when_list_appear(){
        //Arrange
        let expectedValue = 1
        let expectedEventsValue = mockService.limit
        viewModel.viewDidLoad()
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedEventsValue, actualEventsValue)
    }
    
    func test_return_correct_events_when_list_at_last_item_in_first_page(){
        //Arrange
        let expectedValue = 2
        let expectedEventsValue = mockService.limit * 2
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedEventsValue, actualEventsValue)
    }
    
    func test_return_correct_events_when_list_at_center_item_in_second_page(){
        //Arrange
        let expectedValue = 2
        let expectedEventsValue = mockService.limit * 2
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit + mockService.limit/2)
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedEventsValue, actualEventsValue)
    }
    
    func test_return_correct_events_when_list_at_last_item_in_second_page(){
        //Arrange
        let expectedValue = 3
        let expectedEventsValue = mockService.limit * 3
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit*2 - 1)
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedEventsValue, actualEventsValue)
    }
    
    func test_return_correct_events_count_when_list_at_last_item_in_last_page(){
        //Arrange
        let expectedValue = 3
        let expectedEventsValue = mockService.limit * 3
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit*2 - 1)
        viewModel.onItemAppear(mockService.limit*3 - 1)
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedEventsValue, actualEventsValue)
    }
    //Loading
    func test_set_correctload_more_able_when_list_appear(){
        //Arrange
        let expectedValue = true
        viewModel.viewDidLoad()
        //Assign
        let actualValue = viewModel.isLoadMoreable
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    func test_set_correctload_more_able_when_list_ended(){
        //Arrange
        let expectedValue = false
        viewModel.viewDidLoad()
        viewModel.onItemAppear(mockService.limit - 1)
        viewModel.onItemAppear(mockService.limit*2 - 1)
        viewModel.onItemAppear(mockService.limit*3 - 1)
        //Assign
        let actualValue = viewModel.isLoadMoreable
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
   
}

