//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import SwiftUI
import Model

protocol EventRowProtocol {
    func getItemViewType(item: EventSnapshotProtocol) -> Bool
    func createView(event: EventModel) -> any View
}

struct EventRowDelegation {
    private let fallbackEventType = FallbacRowDelegate()
    private var registerdEvent: [EventRowProtocol] = []
    
    let viewModel: EventListViewModel
    
    private func getView(_ item: EventModel) -> any View {
        let snapshot = item.getSnapshotInstance()
        for delegate in registerdEvent {
            if (delegate.getItemViewType(item: snapshot)){
                return delegate.createView(event: item)
            }
        }
        return fallbackEventType.createView(event: item)
    }
    
    func createView(_ item: EventModel) -> AnyView{
        return AnyView(getView(item))
    }
    
    init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        self.registerdEvent.append(NormalEventRowDelegate(viewModel: viewModel))
        self.registerdEvent.append(CheckInOutEventRowDelegate())
        self.registerdEvent.append(EverydayHealthEventRowDelegate())
        self.registerdEvent.append(PortfolioEventRowDelegate())
        self.registerdEvent.append(StoryExportedEventRowDelegate(viewModel: viewModel))
        self.registerdEvent.append(StoryPublishedEventRowDelegate())
    }
}
