//
//  File 4.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct PortfolioEventRowDelegate: EventRowProtocol {
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is PortfolioEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return PortfolioEventView(event: event,
                                  snapshot: event.getSnapshotInstance() as! PortfolioEventSnapshot)
    }
}
