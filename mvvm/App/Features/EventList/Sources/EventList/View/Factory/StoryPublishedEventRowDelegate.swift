//
//  File 6.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model
import SwiftUI

struct StoryPublishedEventRowDelegate: EventRowProtocol {
    func getItemViewType(item: EventSnapshotProtocol) -> Bool {
        return item is StoryPublishedEventSnapshot
    }
    
    func createView(event: EventModel) -> any View {
        return StoryPublishedEventView(event: event,
                                       snapshot: event.getSnapshotInstance() as! StoryPublishedEventSnapshot)
    }
}
