//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI
import Model

public struct EventDetailView: View {
    @ObservedObject var viewModel: EventDetailViewModel
    
    public init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                Text(viewModel.event.eventDescription)
                    .font(.system(size: 14))
                Text(viewModel.event.eventDate.toDate(TimeFormat.isoSimple)?.toDayFormat() ?? "")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.all, 8)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(viewModel.getIconName(), bundle: Bundle.module)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("event.detail.title".localizedString(Bundle.module))
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("color_primary", bundle: Bundle.module))
                    }
                }
            }
        }
    }
}
