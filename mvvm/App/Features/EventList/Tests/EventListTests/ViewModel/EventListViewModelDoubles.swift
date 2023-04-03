//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Combine
import Model
import Networking
@testable import EventList

class MockFailedEventListUsecase: EventListUseCaseProtocol {
    func fetchEvents(page: Int) -> AnyPublisher<[(Date, [EventEntity.EventModel])], Error> {
        return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
    }
}

class MockHappyEventListUsecase: EventListUseCaseProtocol {
    private let mockService : MockHappyCaseEventListNetworkService
    
    init(mockService: MockHappyCaseEventListNetworkService){
        self.mockService = mockService
    }
    
    func fetchEvents(page: Int) -> AnyPublisher<[(Date, [EventEntity.EventModel])], Error> {
        let result = Dictionary(grouping: mockService.firstResponse.data.userTimeline, by: {
            $0.eventDate.toDate(TimeFormat.isoSimple)?.startOfDay ?? Date()
        }).sorted { $0.key > $1.key }
        return Just(result).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

class MockCoordinator: EventCoordinating {
    var isOpenCalled = false
    
    func open(_ event: EventModel) {
        isOpenCalled = true
    }
}

public class MockFailCaseEventListNetworkService: EventListService {
    public func fetchEvents(page: Int) -> AnyPublisher<EventResponse, Error> {
        return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
    }
}

public class MockHappyCaseEventListNetworkService: EventListService {
    public func fetchEvents(page: Int) -> AnyPublisher<EventResponse, Error> {
        switch page {
        case 0:
            return Just(firstResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        case 1:
            return Just(secondResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        case 2:
            return Just(lastResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        default:
            return Just(emptyResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    public let limit = 8
    
    public let emptyResponse = EventResponse.init(data: EventListData.init(userTimeline: []))
    
    public let firstResponse = EventResponse.init(data: EventListData.init(userTimeline: [
        EventModel.init(id: 0,
                        insertedAt: "2022-07-07T15:07:12",
                        eventDate: "2022-07-07T15:07:12",
                        eventDescription: "Normal Event",
                        eventType: .event,
                        eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul \"}"),
        EventModel.init(id: 1,
                        insertedAt: "2022-07-07T15:07:10",
                        eventDate: "2022-07-07T15:07:10",
                        eventDescription: "Logan Crawford just checked in 7 July 2022, 3:11pm",
                        eventType: .checkIn,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 2,
                        insertedAt: "2022-07-07T15:07:9",
                        eventDate: "2022-07-07T15:07:9",
                        eventDescription: "Logan Crawford just checked out 7 July 2022, 3:11pm",
                        eventType: .checkOut,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 3,
                        insertedAt: "2022-07-07T15:07:8",
                        eventDate: "2022-07-07T15:07:8",
                        eventDescription: "everyDayHealth",
                        eventType: .everyDayHealth,
                        eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}"),
        EventModel.init(id: 4,
                        insertedAt: "2022-07-07T15:07:7",
                        eventDate: "2022-07-07T15:07:7",
                        eventDescription: "Logan Crawford has a new learning moment!",
                        eventType: .portfolio,
                        eventSnapshot: "{\"albumId\":\"628355fd-07ec-4f7f-a57e-4168ac180149\",\"albumName\":\"Summer May 17-01\",\"caption\":\"\",\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"fileId\":\"62c684a8-81d8-4c43-b128-48b70a000189\",\"imageUrl\":\"https://ll-staging-oss.oss-ap-southeast-1.aliyuncs.com/medias/20544/62c684a8-7364-48b8-846b-4d270a000189.JPEG\",\"referenceObj\":{\"type\":\"media_tags.id\",\"value\":\"de139884-083f-0f96-4fc9-a393f7f3ca14\"},\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\",\"teacherName\":\"LittleLives Admin\"}"),
        EventModel.init(id: 5,
                        insertedAt: "2022-07-07T15:07:6",
                        eventDate: "2022-07-07T15:07:6",
                        eventDescription: "You have a Story PDF ready for download.",
                        eventType: .storyExported,
                        eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}"),
        EventModel.init(id: 6,
                        insertedAt: "2022-07-07T15:07:5",
                        eventDate: "2022-07-07T15:07:5",
                        eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse",
                        eventType: .storyPublished,
                        eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}"),
        EventModel.init(id: 7,
                        insertedAt: "2022-07-07T15:07:4",
                        eventDate: "2022-07-07T15:07:4",
                        eventDescription: "New Event",
                        eventType: .defaultCase,
                        eventSnapshot: nil)
    ]))
    
    public let secondResponse = EventResponse.init(data: EventListData.init(userTimeline: [
        EventModel.init(id: 8,
                        insertedAt: "2022-07-06T15:06:12",
                        eventDate: "2022-07-06T15:06:12",
                        eventDescription: "Normal Event",
                        eventType: .event,
                        eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul \"}"),
        EventModel.init(id: 9,
                        insertedAt: "2022-07-06T15:06:10",
                        eventDate: "2022-07-06T15:06:10",
                        eventDescription: "Logan Crawford just checked in 7 July 2022, 3:11pm",
                        eventType: .checkIn,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 10,
                        insertedAt: "2022-07-06T15:06:9",
                        eventDate: "2022-07-06T15:06:9",
                        eventDescription: "Logan Crawford just checked out 7 July 2022, 3:11pm",
                        eventType: .checkOut,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 11,
                        insertedAt: "2022-07-06T15:06:8",
                        eventDate: "2022-07-06T15:06:8",
                        eventDescription: "everyDayHealth",
                        eventType: .everyDayHealth,
                        eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}"),
        EventModel.init(id: 12,
                        insertedAt: "2022-07-06T15:06:7",
                        eventDate: "2022-07-06T15:06:7",
                        eventDescription: "Logan Crawford has a new learning moment!",
                        eventType: .portfolio,
                        eventSnapshot: "{\"albumId\":\"628355fd-07ec-4f7f-a57e-4168ac180149\",\"albumName\":\"Summer May 17-01\",\"caption\":\"\",\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"fileId\":\"62c684a8-81d8-4c43-b128-48b70a000189\",\"imageUrl\":\"https://ll-staging-oss.oss-ap-southeast-1.aliyuncs.com/medias/20544/62c684a8-7364-48b8-846b-4d270a000189.JPEG\",\"referenceObj\":{\"type\":\"media_tags.id\",\"value\":\"de139884-083f-0f96-4fc9-a393f7f3ca14\"},\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\",\"teacherName\":\"LittleLives Admin\"}"),
        EventModel.init(id: 13,
                        insertedAt: "2022-07-06T15:06:6",
                        eventDate: "2022-07-06T15:06:6",
                        eventDescription: "You have a Story PDF ready for download.",
                        eventType: .storyExported,
                        eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}"),
        EventModel.init(id: 14,
                        insertedAt: "2022-07-06T15:06:5",
                        eventDate: "2022-07-06T15:06:5",
                        eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse",
                        eventType: .storyPublished,
                        eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}"),
        EventModel.init(id: 15,
                        insertedAt: "2022-07-06T15:06:4",
                        eventDate: "2022-07-06T15:06:4",
                        eventDescription: "New Event",
                        eventType: .defaultCase,
                        eventSnapshot: nil)
    ]))
    
    public let lastResponse = EventResponse.init(data: EventListData.init(userTimeline: [
        EventModel.init(id: 16,
                        insertedAt: "2022-07-05T15:05:12",
                        eventDate: "2022-07-05T15:05:12",
                        eventDescription: "Normal Event",
                        eventType: .event,
                        eventSnapshot: "{\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"eventDate\":\"2022-07-08T00:00:00.000Z\",\"eventTitle\":\"Test Jul \"}"),
        EventModel.init(id: 17,
                        insertedAt: "2022-07-05T15:05:10",
                        eventDate: "2022-07-05T15:05:10",
                        eventDescription: "Logan Crawford just checked in 7 July 2022, 3:11pm",
                        eventType: .checkIn,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 18,
                        insertedAt: "2022-07-05T15:05:9",
                        eventDate: "2022-07-05T15:05:9",
                        eventDescription: "Logan Crawford just checked out 7 July 2022, 3:11pm",
                        eventType: .checkOut,
                        eventSnapshot: "{\"checkinThumb\":\"https://media-cache-ap-2.littlelives.com/square/580/contain/ffffff/http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"checkinUrl\":\"http://littlecheckin.production.s3-ap-southeast-1.amazonaws.com/users/checkin/521eb0fd-7ff4-4d9a-a850-0177740c3493/checkin_521eb0fd-7ff4-4d9a-a850-0177740c3493_2022_07_07_15_11_55.jpg\",\"msgParams\":{\"attendanceRecordId\":\"62c68730-27cc-4716-be1e-44ed0a000189\",\"checkInDate\":\"7 July 2022, 3:11pm\",\"childName\":\"Logan Crawford\",\"rawCheckInDate\":\"2022-07-07 15:11:00\",\"schoolName\":\"LittleLives+Demo 1 (Staging)\"},\"referenceObj\":{\"type\":\"attendance_records.id\",\"value\":\"62c68730-27cc-4716-be1e-44ed0a000189\"},\"schoolId\":20544}"),
        EventModel.init(id: 19,
                        insertedAt: "2022-07-05T15:05:8",
                        eventDate: "2022-07-05T15:05:8",
                        eventDescription: "everyDayHealth",
                        eventType: .everyDayHealth,
                        eventSnapshot: "{\"activityClass\":\"pee\",\"activityId\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\",\"activitySubType\":\"pee\",\"activityType\":\"potty\",\"childName\":\"Logan Crawford\",\"endTime\":null,\"referenceObject\":{\"type\":\"lp_child_activities.id\",\"value\":\"4eca57c1-bba9-4b8e-9e1e-e6e32d480665\"},\"remarks\":\"\",\"schoolId\":20544,\"startTime\":\"2022-07-07T16:50:57\"}"),
        EventModel.init(id: 20,
                        insertedAt: "2022-07-05T15:05:7",
                        eventDate: "2022-07-05T15:05:7",
                        eventDescription: "Logan Crawford has a new learning moment!",
                        eventType: .portfolio,
                        eventSnapshot: "{\"albumId\":\"628355fd-07ec-4f7f-a57e-4168ac180149\",\"albumName\":\"Summer May 17-01\",\"caption\":\"\",\"childId\":\"521eb0fd-7ff4-4d9a-a850-0177740c3493\",\"childName\":\"Logan Crawford\",\"fileId\":\"62c684a8-81d8-4c43-b128-48b70a000189\",\"imageUrl\":\"https://ll-staging-oss.oss-ap-southeast-1.aliyuncs.com/medias/20544/62c684a8-7364-48b8-846b-4d270a000189.JPEG\",\"referenceObj\":{\"type\":\"media_tags.id\",\"value\":\"de139884-083f-0f96-4fc9-a393f7f3ca14\"},\"schoolId\":20544,\"schoolName\":\"LittleLives+Demo 1 (Staging)\",\"teacherName\":\"LittleLives Admin\"}"),
        EventModel.init(id: 21,
                        insertedAt: "2022-07-05T15:05:6",
                        eventDate: "2022-07-05T15:05:6",
                        eventDescription: "You have a Story PDF ready for download.",
                        eventType: .storyExported,
                        eventSnapshot: "{\"exp\":\"2022-07-14T06:58:34\",\"school_id\":20544,\"url\":\"https://s3.ap-southeast-1.amazonaws.com/ll.staging/preview/b87348c9-1317-4d11-a484-e487ec5df8e3.pdf\"}"),
        EventModel.init(id: 22,
                        insertedAt: "2022-07-05T15:05:5",
                        eventDate: "2022-07-05T15:05:5",
                        eventDescription: "Staff Admin'production uploaded a new story (DO NOT EDIT) The Sunny Schoolhouse",
                        eventType: .storyPublished,
                        eventSnapshot: "{\"publisher_id\":\"5e6aee2f-765c-49f2-bfff-47faac1802d7\",\"publisher_name\":\"Staff Admin'production\",\"school_id\":20544,\"story_id\":184,\"story_image\":\"\",\"story_name\":\"(DO NOT EDIT) The Sunny Schoolhouse\"}"),
        EventModel.init(id: 23,
                        insertedAt: "2022-07-05T15:05:4",
                        eventDate: "2022-07-05T15:05:4",
                        eventDescription: "New Event",
                        eventType: .defaultCase,
                        eventSnapshot: nil)
    ]))
    
    
}
