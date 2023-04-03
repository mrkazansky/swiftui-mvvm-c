//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class CheckInOutMessageTests: XCTestCase {
    func test_return_correct_check_in_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 2,
                                                insertedAt: "2022-07-07T15:07:9",
                                                eventDate: "2022-07-07T15:07:9",
                                                eventDescription: "Logan Crawford just checked out 7 July 2022, 3:11pm",
                                                eventType: .checkOut,
                                                eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}")
        let expectedValue = "03:11 PM"
        //Assign
        let actual = (event.getSnapshotInstance() as! CheckInOutEventSnapshot).msgParams.getCheckInDateString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_wrong_check_in_date(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 2,
                                                insertedAt: "2022-07-07T15:07:9",
                                                eventDate: "2022-07-07T15:07:9",
                                                eventDescription: "Logan Crawford just checked out 7 July 2022, 3:11pm",
                                                eventType: .checkOut,
                                                eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07-15:11:00.000\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}")
        let expectedValue = ""
        //Assign
        let actual = (event.getSnapshotInstance() as! CheckInOutEventSnapshot).msgParams.getCheckInDateString()
        //Assert
        XCTAssertEqual(expectedValue, actual)
    }
}
