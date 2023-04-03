//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import SwiftUI
import Model
import AttributedText

struct StoryPublishedEventView: View, EventRowView {
    var event: EventModel
    let snapshot: StoryPublishedEventSnapshot
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("ic_event_portfolio", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("event.row.portfolio".localizedString(Bundle.module).uppercased())
                    .foregroundColor(Color("color_primary", bundle: Bundle.module))
                    .font(.system(size: 14, weight: .medium))
            }
            VStack(alignment: .leading) {
                AttributedText(snapshot.getStyledDescription(event.eventDescription))
                    .font(.system(size: 14))
                    .accessibilityIdentifier("textContent")
            }.padding(.leading, 28)
        }
    }
}
