//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Model

public final class EventDetailViewModel: ObservableObject {
    @Published var event: EventEntity.EventModel
    
    public init(event: EventEntity.EventModel) {
        self.event = event
    }
    
    public func getIconName() -> String{
        switch event.eventType {
        case .event :
            return "ic_event"
        case .everyDayHealth:
            return "ic_event_daily_health"
        case .portfolio, .storyExported, .storyPublished :
            return "ic_event_portfolio"
        case .checkIn, .checkOut :
            return "ic_event_check_in"
        default :
            return "ic_event_default"
        }
    }
}
