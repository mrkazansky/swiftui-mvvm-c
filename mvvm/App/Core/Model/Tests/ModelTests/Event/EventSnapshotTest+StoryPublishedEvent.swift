//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class StoryPublishedSnapshotTests: XCTestCase {
    func test_return_correct_styled_description(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 6,
                                                insertedAt: "2022-07-07T15:07:5",
                                                eventDate: "2022-07-07T15:07:5",
                                                eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse",
                                                eventType: .storyPublished,
                                                eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}")
        let expectedValue = "<b>Staff Admin'production</b> uploaded a new story <b>(DO NOT EDIT) The Sunny Schoolhouse</b>"
        //Assign
        let actual = (event.getSnapshotInstance() as! StoryPublishedEventSnapshot).getStyledDescription(event.eventDescription)
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_wrong_styled_description(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 6,
                                                insertedAt: "2022-07-07T15:07:5",
                                                eventDate: "2022-07-07T15:07:5",
                                                eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse",
                                                eventType: .storyPublished,
                                                eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"ABCAS\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"XXXAS\"}")
        let expectedValue = event.eventDescription
        //Assign
        let actual = (event.getSnapshotInstance() as! StoryPublishedEventSnapshot).getStyledDescription(event.eventDescription)
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
}
