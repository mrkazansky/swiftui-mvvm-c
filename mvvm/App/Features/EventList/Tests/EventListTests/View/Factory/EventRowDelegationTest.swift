//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
import Foundation
import Combine
import SwiftUI
import Utilities
@testable import EventList

class EvenRowDelegationTest: XCTestCase {
    private var usecase : EventListUseCase!
    private let mockService = MockHappyCaseEventListNetworkService()
    private let coordinator = MockCoordinator()
    private var viewModel: EventListViewModel!
    
    var eventRowDelegation: EventRowDelegation!
    
    override func setUp() {
        usecase = EventListUseCase(networkService: mockService)
        viewModel = EventListViewModel(eventListUseCase: usecase, coordinator: coordinator)
        eventRowDelegation = EventRowDelegation(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        usecase = nil
        eventRowDelegation = nil
    }
    
    func test_return_correct_normal_view(){
        //Arrange
        let expectedViewName = String(reflecting: NormalEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[0])
        let actual = result.content.debugDescription
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_normal_view(){
        //Arrange
        let expectedViewName = String(reflecting: NormalEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[1])
        let actual = result.content.debugDescription
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_check_in_view(){
        //Arrange
        let expectedViewName = String(reflecting: CheckInOutEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[1])
        let actual = result.content.debugDescription
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_check_in_view(){
        //Arrange
        let expectedViewName = String(reflecting: CheckInOutEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[0])
        let actual = result.content.debugDescription
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_check_out_view(){
        //Arrange
        let expectedViewName = String(reflecting: CheckInOutEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[2])
        let actual = result.content.debugDescription
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_check_out_view(){
        //Arrange
        let expectedViewName = String(reflecting: CheckInOutEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[0])
        let actual = result.content.debugDescription
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_every_day_health_view(){
        //Arrange
        let expectedViewName = String(reflecting: EverydayHealthEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[3])
        let actual = result.content.debugDescription
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_every_day_health_view(){
        //Arrange
        let expectedViewName = String(reflecting: EverydayHealthEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[0])
        let actual = result.content.debugDescription
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_portfolio_view(){
        //Arrange
        let expectedViewName = String(reflecting: PortfolioEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[4])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_portfolio_view(){
        //Arrange
        let expectedViewName = String(reflecting: PortfolioEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[0])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_story_exported_view(){
        //Arrange
        let expectedViewName = String(reflecting: StoryExportedEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[5])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_story_exported_view(){
        //Arrange
        let expectedViewName = String(reflecting: StoryExportedEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[1])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_story_published_view(){
        //Arrange
        let expectedViewName = String(reflecting: StoryPublishedEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[6])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_story_published_view(){
        //Arrange
        let expectedViewName = String(reflecting: StoryPublishedEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[1])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertFalse(actual.contains(expectedViewName))
    }
    
    func test_return_correct_fall_back_view(){
        //Arrange
        let expectedViewName = String(reflecting: DefaultEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[7])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertTrue(actual.contains(expectedViewName))
    }
    
    func test_return_wrong_story_fallback_view(){
        //Arrange
        let expectedViewName = String(reflecting: DefaultEventView.self)
        //Assign
        let result = eventRowDelegation.createView(mockService.firstResponse.data.userTimeline[1])
        let actual = result.content.debugDescription
        //Assert
        XCTAssertFalse(actual.contains(expectedViewName))
    }
}

