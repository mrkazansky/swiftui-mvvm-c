//
//  HomeCoordinator.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Home
import SwiftUI
import Swinject

class HomeCoordinator: ObservableObject, Identifiable, HomeCoordinating {    
    @Published var homeViewModel: HomeViewModel?
    
    func start() {
        homeViewModel = Container.ApplicationScope.resolve(HomeViewModel.self)!
    }
}

struct HomeCoordinatorView: View {
    @ObservedObject var homeCoordinator: HomeCoordinator
    let eventCoordinatorView: EventCoordinatorView?
    
    init(homeCoordinator: HomeCoordinator, eventCoordinator: EventCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.eventCoordinatorView = EventCoordinatorView(coordinator: eventCoordinator)
    }
    
    var body: some View {
        NavigationView {
            HomeView(homeViewModel: homeCoordinator.homeViewModel!,
                     eventCoordinatorView: eventCoordinatorView)
        }
    }    
}
