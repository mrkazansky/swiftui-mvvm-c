//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI
import Model

protocol EventRowView {
    var event: EventModel { get }
}

struct DefaultEventView: View, EventRowView {            
    var event: EventModel
    
    var body: some View {
        Text("event.row.defaut.message".localizedString(Bundle.module))
    }
}
