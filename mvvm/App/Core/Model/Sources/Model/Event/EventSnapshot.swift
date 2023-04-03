//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Utilities

public protocol EventSnapshotProtocol: Decodable {}

struct EventSnapshot {
    let eventType: EventEntity.EventType
    let snapshotType: EventSnapshotProtocol.Type
}

public struct NormalEventSnapshot : Codable, EventSnapshotProtocol {
    public let childId: String
    public let childName: String
    public let eventDate: String
    public let eventTitle: String
    public let schoolName: String?
    public let schoolId: Int?
    
    public func getEventDateString() -> String {
        return eventDate.toDate(TimeFormat.isoSimple)?.toSimpleDayTimeFormat() ?? ""
    }
}

public struct EverydayHealthEventSnapshot : Codable, EventSnapshotProtocol {
    public let activityClass: String
    public let activityId: String
    public let activitySubType: String
    public let activityType: String
    public let childName: String
    public let endTime: String?
    public let startTime: String?
    public let schoolId: Int
    public let remarks: String?
    public let referenceObject: ReferenceModel
    
    public func getStartTimeString() -> String {
        return startTime?.toDate(TimeFormat.isoSimple)?.toSimpleDayTimeFormat() ?? ""
    }
}

public struct CheckInOutEventSnapshot : Codable, EventSnapshotProtocol {
    public let checkinThumb: String
    public let checkinUrl: String
    public let msgParams: CheckInOutMessage
    public let referenceObj: ReferenceModel
    public let schoolId: Int
}

public struct CheckInOutMessage : Codable {
    public let attendanceRecordId: String
    public let checkInDate: String
    public let childName: String
    public let rawCheckInDate: String
    public let schoolName: String
    
    public func getCheckInDateString() -> String {
        return rawCheckInDate.toDate(TimeFormat.simple)?.toSimpleDayTimeFormat() ?? ""
    }
}

public struct ReferenceModel : Codable {
    public let type: String
    public let value: String
}

public struct PortfolioEventSnapshot : Codable, EventSnapshotProtocol {
    public let albumId: String
    public let albumName: String
    public let caption: String
    public let childId: String
    public let childName: String
    public let fileId: String
    public let imageUrl: String
    public let referenceObj: ReferenceModel
    public let schoolId: Int
    public let schoolName: String
    public let teacherName: String
}

public struct StoryPublishedEventSnapshot : Codable, EventSnapshotProtocol {
    public let publisherId: String
    public let publisherName: String
    public let schoolId: Int
    public let storyId: Int
    public let storyImage: String?
    public let storyName: String
    
    enum CodingKeys: String, CodingKey {
        case publisherId = "publisher_id"
        case publisherName = "publisher_name"
        case schoolId = "school_id"
        case storyId = "story_id"
        case storyImage = "story_image"
        case storyName = "story_name"
    }
    
    public func getStyledDescription(_ description: String) -> String {
        if !description.contains(publisherName) {
            return description
        }
        if !description.contains(storyName) {
            return description
        }
        let startIndex = description.index(description.startIndex, offsetBy: publisherName.count)
        let endIndex = description.index(description.endIndex, offsetBy: -storyName.count)
        return "<b>\(publisherName)</b>\(description[startIndex..<endIndex])<b>\(storyName)</b>"
    }
}

public struct StoryExportedEventSnapshot : Codable, EventSnapshotProtocol {
    public let exp: String
    public let schoolId: Int?
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case exp, url
        case schoolId = "school_id"
    }
    
    public func getFileName() -> String {
        return URL(string: url)?.lastPathComponent ?? ""
    }
}

public struct DefaultEventSnapshot : Codable, EventSnapshotProtocol {}
