//
//  mvvmApp.swift
//  mvvm
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI

@main
struct mvvmApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            appDelegate.rootView
        }
    }
}
