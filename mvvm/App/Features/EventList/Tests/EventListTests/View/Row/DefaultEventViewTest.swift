//
//  File 2.swift
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

class DefaultEventViewTest: XCTestCase {
    func test_happy_case_for_default_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 15,
                                    insertedAt: "2022-07-06T15:06:4",
                                    eventDate: "2022-07-06T15:06:4",
                                    eventDescription: "New Event",
                                    eventType: .defaultCase,
                                    eventSnapshot: nil)
        let expectedValue = "Upcoming Events"
        //Assign
        let view = DefaultEventView(event: event)
        let value = try view.inspect().text().string()
        //Assert
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_fail_case_for_default_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 15,
                                    insertedAt: "2022-07-06T15:06:4",
                                    eventDate: "2022-07-06T15:06:4",
                                    eventDescription: "New Event",
                                    eventType: .event,
                                    eventSnapshot: nil)
        let unexpectedValue = event.eventDescription
        //Assign
        let view = DefaultEventView(event: event)
        let value = try view.inspect().text().string()
        //Assert
        XCTAssertNotEqual(unexpectedValue, value)
    }
}
