//
//  File 2.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class NormalSnapshotTests: XCTestCase {
    func test_return_correct_event_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .event,
                                                eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul \"}")
        let expectedValue = "07:00 AM"
        //Assign
        let actual = (event.getSnapshotInstance() as! NormalEventSnapshot).getEventDateString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_wrong_event_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .event,
                                                eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08 00:00:00.000\",\"eventTitle\":\"Test Jul \"}")
        let expectedValue = ""
        //Assign
        let actual = (event.getSnapshotInstance() as! NormalEventSnapshot).getEventDateString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
}
