//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import SwiftUI
import Model
import AttributedText

struct EverydayHealthEventView: View, EventRowView {
    var event: EventModel
    let snapshot: EverydayHealthEventSnapshot
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("ic_event_daily_health", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("event.row.daily_health"
                    .localizedString(Bundle.module)
                    .uppercased())
                .foregroundColor(Color("color_primary", bundle: Bundle.module))
                .font(.system(size: 14, weight: .medium))
            }
            VStack(alignment: .leading) {
                AttributedText(String(
                    format: "event.row.daily_health.message.holder".localizedString(Bundle.module),
                    snapshot.childName,
                    snapshot.getStartTimeString()
                ))
                .font(.system(size: 14))
            }.padding(.leading, 32)
        }
    }
}
