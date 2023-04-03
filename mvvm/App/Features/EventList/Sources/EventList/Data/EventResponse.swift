//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Model

public struct EventListResponse : Codable {
    let data : EventListData
}

public struct EventListData: Codable {
    let userTimeline: [EventEntity.EventModel]
}
