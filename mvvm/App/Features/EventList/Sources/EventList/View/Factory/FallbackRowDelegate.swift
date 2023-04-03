//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct FallbacRowDelegate: EventRowProtocol {
    func getItemViewType(item: Model.EventSnapshotProtocol) -> Bool {
        return true
    }
    
    func createView(event: EventModel) -> any View {
        return DefaultEventView(event: event)
    }
}
