//
//  ApplicationScope.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Swinject
import Utilities
import Networking
import EventList
import EventDetail
import Home

extension Container {
    static let ApplicationScope: Container = {
        //Network
        let container = Container()
        container.register(HTTPClient.self, factory: { _ in
            URLSessionClient()
        })
        .inObjectScope(.container)
        //Event
        container.register(EventCoordinating.self, factory: {_ in EventCoordinator()})
            .inObjectScope(.container)
        container.register(EventCoordinator.self){
            $0.resolve(EventCoordinating.self)! as! EventCoordinator
        }.initCompleted { _ , coordinator in
            coordinator.start()
        }
        //Home
        container.register(HomeCoordinating.self, factory: {_ in
            HomeCoordinator()
        })
        .inObjectScope(.container)
        container.register(HomeCoordinator.self) {
            $0.resolve(HomeCoordinating.self)! as! HomeCoordinator
        }
        container.register(HomeViewModel.self) { _ in
            HomeViewModel()
        }
        return container
    }()
}

