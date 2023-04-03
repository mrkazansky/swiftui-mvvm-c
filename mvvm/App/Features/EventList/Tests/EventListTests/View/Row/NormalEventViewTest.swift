//
//  File 3.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
import SwiftUI
import Model
import ViewInspector
import AttributedText
@testable import EventList

class NormalEventViewTest: XCTestCase {
    private var usecase : EventListUseCase!
    internal let mockService = MockFailCaseEventListNetworkService()
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
    
    func test_happy_simple_case_for_normal_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 15,
                                    insertedAt: "2022-07-06T15:06:4",
                                    eventDate: "2022-07-06T15:06:4",
                                    eventDescription: "Event",
                                    eventType: .event,
                                    eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul\"}")
        let snapshot = event.getSnapshotInstance() as! NormalEventSnapshot
        let expectedValue = "Test Jul on 07:00 AM"
        let expectedValueTitle = "event.row.normal".localizedString(Bundle.module).uppercased()
        //Assign
        let view = NormalEventView(event: event, snapshot: snapshot, viewModel: viewModel)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
    
    func test_happy_full_case_for_normal_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 15,
                                    insertedAt: "2022-07-06T15:06:4",
                                    eventDate: "2022-07-06T15:06:4",
                                    eventDescription: "Event",
                                    eventType: .event,
                                    eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-07T15:26:00.000Z\",\"eventTitle\":\"School level - Events\",\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\"}")
        let snapshot = event.getSnapshotInstance() as! NormalEventSnapshot
        let expectedValue = "LittleLives+Demo 1 (Staging) created an event School level - Events on 10:26 PM"
        let expectedValueTitle = "event.row.normal".localizedString(Bundle.module).uppercased()
        //Assign
        let view = NormalEventView(event: event, snapshot: snapshot, viewModel: viewModel)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
}
