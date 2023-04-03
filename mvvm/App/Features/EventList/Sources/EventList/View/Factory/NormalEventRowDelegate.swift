//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct NormalEventRowDelegate: EventRowProtocol {
    let viewModel: EventListViewModel
    
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is NormalEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return NormalEventView(event: event,
                               snapshot: event.getSnapshotInstance() as! NormalEventSnapshot,
                               viewModel: viewModel)
    }    
}
