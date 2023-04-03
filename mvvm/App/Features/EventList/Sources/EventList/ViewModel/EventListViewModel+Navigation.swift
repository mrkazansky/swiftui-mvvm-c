//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Model

internal extension EventListViewModel {
    func open(_ event: EventModel) {
        coordinator?.open(event)
    }
    
    func downloadPorfolio(){
        print(#function)
    }
    
    func addCalendar(){
        print(#function)
    }
}
