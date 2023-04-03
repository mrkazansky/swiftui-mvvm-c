//
//  File 4.swift
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

class EverydayHealthEventViewTest: XCTestCase {
    private let eventSnapshot = "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}"

    func test_happy_case_for_everyday_health_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 15,
                                    insertedAt: "2022-07-06T15:06:4",
                                    eventDate: "2022-07-06T15:06:4",
                                    eventDescription: "Event",
                                    eventType: .everyDayHealth,
                                    eventSnapshot: eventSnapshot)
        let snapshot = event.getSnapshotInstance() as! EverydayHealthEventSnapshot        
        let expectedValue = "Logan Crawford got new daily health update at 04:50 PM"
        let expectedValueTitle = "Daily health".uppercased()
        //Assign
        let view = EverydayHealthEventView(event: event, snapshot: snapshot)        
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
}
