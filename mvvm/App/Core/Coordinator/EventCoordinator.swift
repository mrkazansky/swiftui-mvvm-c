//
//  EventCoordinator.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import SwiftUI
import Swinject
import EventList
import EventDetail

class EventCoordinator: ObservableObject, Identifiable, EventCoordinating {
    @Published var viewModel: EventListViewModel?
    @Published var detailViewModel: EventDetailViewModel?
    
    func start() {
        viewModel = Container.EventListScope.resolve(EventListViewModel.self)!
    }
    
    func open(_ event: EventModel) {
        detailViewModel = Container.EventDetailScope.resolve(EventDetailViewModel.self, argument: event)
    }
}

struct EventCoordinatorView: View {
    @ObservedObject var coordinator: EventCoordinator
    
    var body: some View {
        EventListView(viewModel: coordinator.viewModel!)
            .navigation(item: $coordinator.detailViewModel) { viewModel in
                EventDetailView(viewModel: viewModel)
            }        
    }
}

