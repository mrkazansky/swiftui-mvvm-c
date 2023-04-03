//
//  File.swift
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

class StoryPublishedEventViewTests: XCTestCase {
    func test_happy_case_for_story_published_event_view() throws {
        //Arrange
        let event = EventModel(id: 1, insertedAt: "2022-04-01T00:00:00.000Z", eventDate: "2022-04-01T00:00:00.000Z", eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse", eventType: .storyPublished, eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}")
        let snapshot = event.getSnapshotInstance() as! StoryPublishedEventSnapshot
        let expectedValue = event.eventDescription
        let expectedValueTitle = "event.row.portfolio".localizedString(Bundle.module).uppercased()
        //Assign
        let view = StoryPublishedEventView(event: event, snapshot: snapshot)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
    
    func test_fail_case_for_story_published_event_view() throws {
        //Arrange
        let event = EventModel(id: 1, insertedAt: "2022-04-01T00:00:00.000Z", eventDate: "2022-04-01T00:00:00.000Z", eventDescription: "!This will make error", eventType: .storyPublished, eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}")
        let snapshot = event.getSnapshotInstance() as! StoryPublishedEventSnapshot
        let expectedValue = event.eventDescription
        //Assign
        let view = StoryPublishedEventView(event: event, snapshot: snapshot)
        let value = try view.inspect().find(AttributedText.self).text().string()
        //Assert
        XCTAssertEqual(expectedValue, value)
    }
}
