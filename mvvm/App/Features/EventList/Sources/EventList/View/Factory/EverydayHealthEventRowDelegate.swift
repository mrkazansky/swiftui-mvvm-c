//
//  File 2.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct EverydayHealthEventRowDelegate: EventRowProtocol {        
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is EverydayHealthEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return EverydayHealthEventView(event: event,
                                       snapshot: event.getSnapshotInstance() as! EverydayHealthEventSnapshot)
    }
}
