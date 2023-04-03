//
//  File.swift
//  
//
//  Created by Bills on 03/04/2023.
//

import XCTest
@testable import Model

final class EventEntityTests: XCTestCase {
    func test_return_correct_snapshot_for_normal_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .event,
                                                eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul \"}")
        let expectedValue = "Logan Crawford"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! NormalEventSnapshot).childName
        //Assert
        XCTAssertTrue(type(of: snapshot) == NormalEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_normal_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .event,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_default_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: EventEntity.EventType(rawValue: "XXX") ?? .defaultCase, eventSnapshot: "{}")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_check_in_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkIn,
                                                eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}")
        let expectedValue = "Logan Crawford"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! CheckInOutEventSnapshot).msgParams.childName
        //Assert
        XCTAssertTrue(type(of: snapshot) == CheckInOutEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_check_in_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkIn,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_check_out_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkOut,
                                                eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}")
        let expectedValue = "Logan Crawford"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! CheckInOutEventSnapshot).msgParams.childName
        //Assert
        XCTAssertTrue(type(of: snapshot) == CheckInOutEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_check_out_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .checkOut,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_everyday_health_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .everyDayHealth,
                                                eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}")
        let expectedValue = "Logan Crawford"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! EverydayHealthEventSnapshot).childName
        //Assert
        XCTAssertTrue(type(of: snapshot) == EverydayHealthEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_everday_health_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .everyDayHealth,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_portfolio_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .portfolio,
                                                eventSnapshot: "{\"albumId\":\"628355fd-07ec-4f7f-a57e-4168ac180149\",\"albumName\":\"Summer May 17-01\",\"caption\":\"\",\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"fileId\":\"62c684a8-81d8-4c43-b128-48b70a000189\",\"imageUrl\":\"https://ll-staging-oss.oss-ap-southeast-1.aliyuncs.com/medias/20544/62c684a8-7364-48b8-846b-4d270a000189.JPEG\",\"referenceObj\":{\"type\":\"media_tags.id\",\"value\":\"de139884-083f-0f96-4fc9-a393f7f3ca14\"},\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\",\"teacherName\":\"LittleLives Admin\"}")
        let expectedValue = "Logan Crawford"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! PortfolioEventSnapshot).childName
        //Assert
        XCTAssertTrue(type(of: snapshot) == PortfolioEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_portfolio_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .portfolio,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_story_exported_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyExported,
                                                eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}")
        let expectedValue = 20544
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! StoryExportedEventSnapshot).schoolId
        //Assert
        XCTAssertTrue(type(of: snapshot) == StoryExportedEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_story_exported_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyExported,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
    func test_return_correct_snapshot_for_story_published_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyPublished,
                                                eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}")
        let expectedValue = "(DO NOT EDIT) The Sunny Schoolhouse"
        //Assign
        let snapshot = event.getSnapshotInstance()
        let actual = (snapshot as! StoryPublishedEventSnapshot).storyName
        //Assert
        XCTAssertTrue(type(of: snapshot) == StoryPublishedEventSnapshot.self)
        XCTAssertEqual(expectedValue, actual)
    }
    
    func test_return_fail_snapshot_for_story_published_event(){
        //Arrange
        let event = EventEntity.EventModel.init(id: 0,
                                                insertedAt: "2022-07-07T15:07:12",
                                                eventDate: "2022-07-07T15:07:12",
                                                eventDescription: "Normal Event",
                                                eventType: .storyPublished,
                                                eventSnapshot: "")
        //Assign
        let snapshot = event.getSnapshotInstance()
        //Assert
        XCTAssertTrue(type(of: snapshot) == DefaultEventSnapshot.self)
    }
    
}
