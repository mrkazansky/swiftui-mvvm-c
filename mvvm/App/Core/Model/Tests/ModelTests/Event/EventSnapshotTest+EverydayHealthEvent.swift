//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class EverydayHealthSnapshotTests: XCTestCase {
    func test_return_correct_event_start_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 3,
                                                insertedAt: "2022-07-07T15:07:8",
                                                eventDate: "2022-07-07T15:07:8",
                                                eventDescription: "everyDayHealth",
                                                eventType: .everyDayHealth,
                                                eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}")
        let expectedValue = "04:50 PM"
        //Assign
        let actual = (event.getSnapshotInstance() as! EverydayHealthEventSnapshot).getStartTimeString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_wrong_event_start_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 3,
                                                insertedAt: "2022-07-07T15:07:8",
                                                eventDate: "2022-07-07T15:07:8",
                                                eventDescription: "everyDayHealth",
                                                eventType: .everyDayHealth,
                                                eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07-16:50:57.000\"}")
        let expectedValue = ""
        //Assign
        let actual = (event.getSnapshotInstance() as! EverydayHealthEventSnapshot).getStartTimeString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
}
