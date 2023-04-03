//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import SwiftUI
import Model
import Kingfisher
import Utilities
import AttributedText

struct NormalEventView: View, EventRowView {
    @ObservedObject private var viewModel: EventListViewModel
    
    var event: EventModel
    let snapshot : NormalEventSnapshot
    
    init(event: EventModel, snapshot: NormalEventSnapshot, viewModel: EventListViewModel) {
        self.viewModel = viewModel
        self.event = event
        self.snapshot = snapshot
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("ic_event", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("event.row.normal"
                    .localizedString(Bundle.module)
                    .uppercased())
                .foregroundColor(Color("color_primary", bundle: Bundle.module))
                .font(.system(size: 14, weight: .medium))
            }
            VStack(alignment: .leading) {
                if let schoolName = snapshot.schoolName {
                    AttributedText(String(
                        format: "event.row.message.holder".localizedString(Bundle.module),
                        schoolName,
                        snapshot.eventTitle,
                        snapshot.getEventDateString()))
                    .font(.system(size: 14))
                    
                } else {
                    AttributedText(String(
                        format: "event.row.message.simple.holder".localizedString(Bundle.module),
                        snapshot.eventTitle,
                        snapshot.getEventDateString()))
                    .font(.system(size: 14))
                }
                Button(action: {
                    viewModel.addCalendar()
                }) {
                    HStack(alignment: .top) {
                        Text("action.add"
                            .localizedString(Bundle.module))
                        .font(.system(size: 14, weight: .medium))
                        Image("ic_calendar", bundle: Bundle.module)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .foregroundColor(.white)
                    .background(Color("color_primary", bundle: Bundle.module))
                    .cornerRadius(4)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("button_add_event")
            }.padding(.leading, 28)
        }
    }
}
