//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import EventList

extension EventListViewModelHappyCaseTest {
    func test_coordinator_open_is_called(){
        //Assign
        viewModel.open(mockService.firstResponse.data.userTimeline[0])
        //Assert
        XCTAssertTrue(coordinator.isOpenCalled)
    }
}
