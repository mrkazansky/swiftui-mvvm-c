//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Combine
import Model

public typealias EventModel = EventEntity.EventModel

public protocol EventCoordinating: AnyObject {
    func open(_ event: EventModel)
}

public final class EventListViewModel: ObservableObject {
    @Published var error: Error?
    @Published var events: [(Date, [EventModel])] = []
    @Published var isLoading: Bool = false
    
    internal let eventListUseCase: EventListUseCaseProtocol
    internal let coordinator: EventCoordinating?
    internal var cancellables: Set<AnyCancellable> = []
    
    internal var currentPage = 0
    internal var isLoadMoreable = true
    internal var totalItem = 0
    
    public init(eventListUseCase: EventListUseCaseProtocol,
                coordinator: EventCoordinating? = nil) {
        self.eventListUseCase = eventListUseCase
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        isLoadMoreable = true
        fetchEvents()
    }
}
