//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation


extension Date {
    public func toSimpleDayTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: self)
    }
    
    public func toDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: self)
    }
        
    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
}
