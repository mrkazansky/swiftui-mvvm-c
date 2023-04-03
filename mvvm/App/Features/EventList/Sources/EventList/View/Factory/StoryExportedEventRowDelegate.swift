//
//  File 5.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct StoryExportedEventRowDelegate: EventRowProtocol {
    let viewModel: EventListViewModel
    
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is StoryExportedEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return StoryExportedEventView(event: event,
                                      snapshot: event.getSnapshotInstance() as! StoryExportedEventSnapshot,
                                      viewModel: viewModel)
    }
}
