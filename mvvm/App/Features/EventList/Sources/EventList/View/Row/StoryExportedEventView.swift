//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import SwiftUI
import Model
import AttributedText

struct StoryExportedEventView: View, EventRowView {
    @ObservedObject private var viewModel: EventListViewModel
    
    var event: EventModel
    let snapshot: StoryExportedEventSnapshot
    
    init(event: EventModel, snapshot: StoryExportedEventSnapshot, viewModel: EventListViewModel) {
        self.event = event
        self.snapshot = snapshot
        self.viewModel = viewModel
    }
    
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
                Text("\(event.eventDescription) \(snapshot.getFileName())")
                    .font(.system(size: 14))
                Button(action: {
                    viewModel.downloadPorfolio()
                }) {
                    HStack(alignment: .top) {
                        Text("action.download".localizedString(Bundle.module))
                            .font(.system(size: 14, weight: .medium))
                        Image("ic_download", bundle: Bundle.module)
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
            }.padding(.leading, 28)
        }
    }
}
