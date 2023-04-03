//
//  EventListContainer.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation

import Swinject
import EventList
import Networking

extension Container {
    static let EventListScope: Container = {
        let container = Container(parent: ApplicationScope)
        container.register(EventListService.self, factory: { resolver in
            FakeEventListNetworkService(client: resolver.resolve(HTTPClient.self)!)
        })
        container.register(EventListUseCaseProtocol.self, factory: { resolver in
            EventListUseCase(networkService: resolver.resolve(EventListService.self)!)
        })
        container.register(EventListViewModel.self, factory: {resolver in
            EventListViewModel(eventListUseCase: resolver.resolve(EventListUseCaseProtocol.self)!,
                               coordinator: resolver.resolve(EventCoordinating.self))
        })
        return container
    }()
}
