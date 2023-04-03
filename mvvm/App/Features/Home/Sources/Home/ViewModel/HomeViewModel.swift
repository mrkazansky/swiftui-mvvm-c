//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation

enum HomeTab : Int {
    case news = 0
    case checkin = 1
    case inbox = 2
    case portfolio = 3
    case menu = 4
}

public protocol HomeCoordinating: AnyObject {
    func start()
}

public final class HomeViewModel: ObservableObject {
    @Published var selectedTab = HomeTab.news
    
    public init() {}
    
    func openAccountScreen(){
        print(#function)
    }
    
    func shareFeedback(){
        print(#function)
    }
    
    func scanSomething(){
        print(#function)
    }
}
