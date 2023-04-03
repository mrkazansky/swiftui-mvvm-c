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

class CheckInOutEventViewTest: XCTestCase {
    private let checkInSnapshotJson = "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"
    
    func test_happy_case_for_check_in_event_view() throws {
        //Arrange
        let event = EventModel(id: 1, insertedAt: "2022-04-01T00:00:00.000Z", eventDate: "2022-04-01T00:00:00.000Z", eventDescription: "", eventType: .checkIn, eventSnapshot: checkInSnapshotJson)
        let snapshot = event.getSnapshotInstance() as! CheckInOutEventSnapshot
        let expectedValue = "Logan Crawford checked in on 03:11 PM"
        let expectedValueTitle = "event.row.checkin".localizedString(Bundle.module).uppercased()
        //Assign
        let view = CheckInOutEventView(event: event, snapshot: snapshot)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().hStack().vStack(0).hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
    
    func test_happy_case_for_check_out_event_view() throws {
        //Arrange
        let event = EventModel(id: 1, insertedAt: "2022-04-01T00:00:00.000Z", eventDate: "2022-04-01T00:00:00.000Z", eventDescription: "", eventType: .checkOut, eventSnapshot: checkInSnapshotJson)
        let snapshot = event.getSnapshotInstance() as! CheckInOutEventSnapshot
        let expectedValue = "Logan Crawford checked out on 03:11 PM"
        let expectedValueTitle = "event.row.checkin".localizedString(Bundle.module).uppercased()
        //Assign
        let view = CheckInOutEventView(event: event, snapshot: snapshot)
        let value = try view.inspect().find(AttributedText.self).text().string()
        let valueTitle = try view.inspect().hStack().vStack(0).hStack(0).text(1).string()
        //Assert
        XCTAssertEqual(expectedValue, value)
        XCTAssertEqual(expectedValueTitle, valueTitle)
    }
}
