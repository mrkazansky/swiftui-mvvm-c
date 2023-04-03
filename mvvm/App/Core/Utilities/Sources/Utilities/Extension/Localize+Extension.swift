//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    public var string: String {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String ?? ""
    }
}

