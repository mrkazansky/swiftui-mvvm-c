//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import SwiftUI
import Model
import AttributedText

struct PortfolioEventView: View, EventRowView {
    var event: EventModel
    let snapshot: PortfolioEventSnapshot
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("ic_event_portfolio", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("event.row.portfolio"
                    .localizedString(Bundle.module)
                    .uppercased())
                .foregroundColor(Color("color_primary", bundle: Bundle.module))
                .font(.system(size: 14, weight: .medium))
            }
            VStack(alignment: .leading) {
                AttributedText("<b>\(snapshot.childName)</b>\(event.eventDescription.suffix(from: snapshot.childName.endIndex))")
                    .font(.system(size: 14))
            }.padding(.leading, 28)
        }
    }
}
