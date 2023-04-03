//
//  SwiftUIView.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI
import Combine
import Utilities

struct EventFooter : View {
    let text: String
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading){
                Spacer()
                Text(text)
                    .padding(.leading, 28)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .background(Color.gray.opacity(0.5))
    }
}

public struct EventListView: View {
    @ObservedObject private var viewModel: EventListViewModel
    private let eventRowDelegation: EventRowDelegation!

    public init(viewModel: EventListViewModel) {
        self.viewModel = viewModel
        self.eventRowDelegation = EventRowDelegation(viewModel: viewModel)
    }
    
    public var body: some View {
        List {
            ForEach($viewModel.events, id: \.0) { $group in
                Section(content: {
                    ForEach($group.1) { event in
                        eventRowDelegation
                            .createView(event.wrappedValue)
                            .onNavigation {
                                viewModel.open(event.wrappedValue)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .onAppear {
                                viewModel.onItemAppear(event.wrappedValue.id)                                
                            }
                            .accessibilityIdentifier("event_row_\(event.id)")
                    }
                }, footer: {
                    EventFooter(text: group.0.toDayFormat())
                })
            }
            .listRowInsets(EdgeInsets())
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("event_list")
        .listStyle(PlainListStyle())
        .onViewDidLoad {
            viewModel.viewDidLoad()
        }       
        .errorAlert(error: $viewModel.error)
        .navigationBarItems(
            leading: Button(action: {
            }, label: {
                Image("ic_user", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }),
            trailing:
                HStack {
                    Button(action: {
                    }, label: {
                        Text("toolbar.feedback".localizedString(Bundle.module))
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .overlay(
                                RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    })
                    
                    Button(action: {
                    }, label: {
                        Image("ic_scan", bundle: Bundle.module)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                    })
                }
        )
    }
}
