//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI
import Model
import Kingfisher
import Utilities
import AttributedText

struct CheckInOutEventView: View, EventRowView {
    var event: EventModel
    let snapshot: CheckInOutEventSnapshot
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                HStack {
                    Image("ic_event_check_in", bundle: Bundle.module)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("event.row.checkin".localizedString(Bundle.module).uppercased())
                        .foregroundColor(Color("color_primary", bundle: Bundle.module))
                        .font(.system(size: 14, weight: .medium))
                    
                }
                AttributedText(String(
                    format: "event.row.checkin.message.holder".localizedString(Bundle.module),
                    snapshot.msgParams.childName,
                    (event.eventType == EventEntity.EventType.checkIn ? "event.row.checkin.in" : "event.row.checkin.out").localizedString(Bundle.module),
                    snapshot.msgParams.getCheckInDateString()
                ))
                .font(.system(size: 14))
                .padding(.leading, 28)
            }
            Spacer()
            KFImage(URL(string: snapshot.checkinUrl))
                .placeholder {
                    Image("img_place_holder", bundle: Bundle.module)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(16)
        }
    }
}
