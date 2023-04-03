//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import Foundation

import XCTest
@testable import EventList

extension EventListViewModelFailCaseTest {    
    func test_return_correct_event_count_when_list_at_center_item_error(){
        //Arrange
        let expectedValue = 0
        viewModel.viewDidLoad()
        //Assign
        let actualValue = viewModel.totalItem
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
    }
    
    func test_return_correct_events_when_list_at_center_item_error(){
        //Arrange
        let expectedValue = 0
        viewModel.viewDidLoad()
        //Assign
        let actualValue = viewModel.events.count
        let actualEventsValue = viewModel.events.flatMap { $0.1 }.count
        //Assert
        XCTAssertEqual(expectedValue, actualValue)
        XCTAssertEqual(expectedValue, actualEventsValue)
    }
}
