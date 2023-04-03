//
//  File 5.swift
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

class PortfolioEventViewTests: XCTestCase {
    func test_happy_case_for_portfolio_event_view() throws {
        //Arrange
        let event = EventModel.init(id: 4,
                                    insertedAt: "2022-07-07T15:07:7",
                                    eventDate: "2022-07-07T15:07:7",
                                    eventDescription: "Logan Crawford has a new learning moment!",
                                    eventType: .portfolio,
                                    eventSnapshot: "{\"albumId\":\"628355fd-07ec-4f7f-a57e-4168ac180149\",\"albumName\":\"Summer May 17-01\",\"caption\":\"\",\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"fileId\":\"62c684a8-81d8-4c43-b128-48b70a000189\",\"imageUrl\":\"https://ll-staging-oss.oss-ap-southeast-1.aliyuncs.com/medias/20544/62c684a8-7364-48b8-846b-4d270a000189.JPEG\",\"referenceObj\":{\"type\":\"media_tags.id\",\"value\":\"de139884-083f-0f96-4fc9-a393f7f3ca14\"},\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\",\"teacherName\":\"LittleLives Admin\"}")
        let snapshot = event.getSnapshotInstance() as! PortfolioEventSnapshot
        let expectedValue = event.eventDescription
        let expectedValueTitle = "event.row.portfolio".localizedString(Bundle.module).uppercased()
        //Assign
        let view = PortfolioEventView(event: event, snapshot: snapshot)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().vStack().hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }    
}
