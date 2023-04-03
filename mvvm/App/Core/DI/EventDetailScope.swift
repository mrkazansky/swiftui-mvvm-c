//
//  EventDetailScope.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Swinject
import EventDetail

extension Container {
    public static let EventDetailScope: Container = {
        let container = Container()
        container.register(EventDetailViewModel.self) { _, event in
            EventDetailViewModel(event: event)
        }
        return container
    }()
}
