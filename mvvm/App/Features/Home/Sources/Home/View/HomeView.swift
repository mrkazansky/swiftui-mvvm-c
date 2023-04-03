//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI
import StatefulTabView
import Utilities

struct DummyView: View {
    let text: String
    var body: some View {
        Text(text)
    }
}

public struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    private let eventCoordinatorView: any View
    
    public init(homeViewModel: HomeViewModel, eventCoordinatorView:  any View) {
        self.homeViewModel = homeViewModel
        self.eventCoordinatorView = eventCoordinatorView
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            StatefulTabView(selectedIndex: Binding<Int>(
                get: {homeViewModel.selectedTab.rawValue},
                set: {homeViewModel.selectedTab = HomeTab(rawValue: $0) ?? .news}
            )) {
                Tab(title: "home.news".localizedString(Bundle.module),
                    image: UIImage(named: "ic_bottom_news", in: Bundle.module, compatibleWith: nil)) {
                    AnyView(self.eventCoordinatorView)
                }
                Tab(title: "home.checkin".localizedString(Bundle.module),
                    image: UIImage(named: "ic_bottom_check_in", in: Bundle.module, compatibleWith: nil)) {
                    DummyView(text: "TODO")
                    
                }
                Tab(title: "home.inbox".localizedString(Bundle.module),
                    image: UIImage(named: "ic_bottom_chat", in: Bundle.module, compatibleWith: nil), badgeValue: "99") {
                    NavigationView {
                        DummyView(text: "TODO")
                    }
                }
                Tab(title: "home.portfolio".localizedString(Bundle.module),
                    image: UIImage(named: "ic_bottom_portfolio", in: Bundle.module, compatibleWith: nil)) {
                    NavigationView {
                        DummyView(text: "TODO")
                    }
                }
                Tab(title: "home.more".localizedString(Bundle.module),
                    image: UIImage(named: "ic_bottom_menu", in: Bundle.module, compatibleWith: nil), badgeValue: "") {
                    NavigationView {
                        DummyView(text: "TODO")
                    }
                }
            }
            .barTintColor(UIColor(Color("color_primary", bundle: Bundle.module)))
            .barBackgroundColor(.white)
            .barAppearanceConfiguration(.transparent)
            Rectangle().frame(height: 1).padding(.bottom, 48).foregroundColor(.black.opacity(0.1))
        }
    }
}
