//
//  AppDelegate.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import UIKit
import Swinject

class AppDelegate: NSObject, UIApplicationDelegate {
    private let homeCoordinator = Container.ApplicationScope.resolve(HomeCoordinator.self)!
    private let eventCoordinator = Container.ApplicationScope.resolve(EventCoordinator.self)!
    lazy var rootView = HomeCoordinatorView(homeCoordinator: homeCoordinator, eventCoordinator: eventCoordinator)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        homeCoordinator.start()
        return true
    }
}

