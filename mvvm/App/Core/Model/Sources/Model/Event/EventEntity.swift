//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation

public struct EventEntity {
    public struct EventModel: Codable, Identifiable {
        public var id: Int = 0
        public let insertedAt: String
        public let eventDate: String
        public let eventDescription: String
        public let eventType: EventType
        private let eventSnapshot: String?
        
        enum CodingKeys: String, CodingKey {
            case id, eventDate, eventDescription, eventSnapshot, eventType, insertedAt
        }
        
        public init(id: Int, insertedAt: String, eventDate: String, eventDescription: String, eventType: EventType, eventSnapshot: String?) {
            self.id = id
            self.insertedAt = insertedAt
            self.eventDate = eventDate
            self.eventDescription = eventDescription
            self.eventType = eventType
            self.eventSnapshot = eventSnapshot
        }
        
        public init(id: Int, event : EventModel) {
            self.id = id
            self.eventDate = event.eventDate
            self.eventDescription = event.eventDescription
            self.eventSnapshot = event.eventSnapshot
            self.eventType = event.eventType
            self.insertedAt = event.insertedAt
        }
        
        public init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<EventEntity.EventModel.CodingKeys> = try decoder.container(keyedBy: EventEntity.EventModel.CodingKeys.self)
            self.eventDate = try container.decode(String.self, forKey: EventEntity.EventModel.CodingKeys.eventDate)
            self.eventDescription = try container.decode(String.self, forKey: EventEntity.EventModel.CodingKeys.eventDescription)
            self.eventSnapshot = try container.decode(String.self, forKey: EventEntity.EventModel.CodingKeys.eventSnapshot)
            self.eventType = try container.decode(EventEntity.EventType.self, forKey: EventEntity.EventModel.CodingKeys.eventType)
            self.insertedAt = try container.decode(String.self, forKey: EventEntity.EventModel.CodingKeys.insertedAt)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: EventEntity.EventModel.CodingKeys.self)
            try container.encode(self.id, forKey: EventEntity.EventModel.CodingKeys.id)
            try container.encode(self.eventDate, forKey: EventEntity.EventModel.CodingKeys.eventDate)
            try container.encode(self.eventDescription, forKey: EventEntity.EventModel.CodingKeys.eventDescription)
            try container.encode(self.eventSnapshot, forKey: EventEntity.EventModel.CodingKeys.eventSnapshot)
            try container.encode(self.eventType, forKey: EventEntity.EventModel.CodingKeys.eventType)
            try container.encode(self.insertedAt, forKey: EventEntity.EventModel.CodingKeys.insertedAt)
        }
        
        public func getSnapshotInstance() -> EventSnapshotProtocol {
            guard let jsonData = eventSnapshot?.data(using: .utf8) else { return DefaultEventSnapshot() }
            let decoder = JSONDecoder()
            do {
                let targetSnapshot = registeredSnapshotInstances.first(where: {$0.eventType == eventType}) ?? defaultSnapshot
                let result = try decoder.decode(targetSnapshot.snapshotType, from: jsonData)
                return result
            } catch let error {
                print(error)
                return DefaultEventSnapshot()
            }
        }
        
        private let defaultSnapshot = EventSnapshot(eventType: .defaultCase, snapshotType: DefaultEventSnapshot.self)
        
        private let registeredSnapshotInstances = [
            EventSnapshot(eventType: .defaultCase, snapshotType: DefaultEventSnapshot.self),
            EventSnapshot(eventType: .event, snapshotType: NormalEventSnapshot.self),
            EventSnapshot(eventType: .everyDayHealth, snapshotType: EverydayHealthEventSnapshot.self),
            EventSnapshot(eventType: .checkIn, snapshotType: CheckInOutEventSnapshot.self),
            EventSnapshot(eventType: .checkOut, snapshotType: CheckInOutEventSnapshot.self),
            EventSnapshot(eventType: .portfolio, snapshotType: PortfolioEventSnapshot.self),
            EventSnapshot(eventType: .storyPublished, snapshotType: StoryPublishedEventSnapshot.self),
            EventSnapshot(eventType: .storyExported, snapshotType: StoryExportedEventSnapshot.self)
        ]
    }
    
    public enum EventType: String, Codable {
        case event = "event"
        case everyDayHealth = "everydayHealth"
        case checkOut = "checkOut"
        case checkIn = "checkIn"
        case portfolio = "portfolio"
        case storyExported = "story_exported"
        case storyPublished = "story_published"
        case defaultCase = ""        
    }
}

