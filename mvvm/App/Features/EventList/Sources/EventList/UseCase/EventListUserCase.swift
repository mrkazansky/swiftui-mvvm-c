//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Combine
import Model
import Utilities

public protocol EventListUseCaseProtocol {
    func fetchEvents(page: Int) -> AnyPublisher<[(Date, [EventEntity.EventModel])], Error>
}

public struct EventListUseCase: EventListUseCaseProtocol {
    private let networkService: EventListService
    
    public init(networkService: EventListService) {
        self.networkService = networkService
    }
    
    public func fetchEvents(page: Int) -> AnyPublisher<[(Date, [EventEntity.EventModel])], Error> {
        networkService.fetchEvents(page: page)
            .map { events in
                let indexedEvents = events
                    .data
                    .userTimeline
                    .enumerated()
                    .map { index, event in
                        //fake Id
                        EventModel.init(id: index + page * 20, event: event)
                    }                
                return Dictionary(grouping: indexedEvents, by: {
                    $0.eventDate.toDate(TimeFormat.isoSimple)?.startOfDay ?? Date()
                })
                .sorted { $0.key > $1.key }
            }
            .eraseToAnyPublisher()
    }
}
