//
//  File 3.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct CheckInOutEventRowDelegate: EventRowProtocol {
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is CheckInOutEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return CheckInOutEventView(event: event,
                                   snapshot: event.getSnapshotInstance() as! CheckInOutEventSnapshot)
    }
}
