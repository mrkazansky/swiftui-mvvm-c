//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI

public extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

extension AnyView {
   public var content: Any? {
        let mirror = Mirror(reflecting: self)
        let displayStyle = mirror.displayStyle
        if displayStyle == .optional {
            if let child = mirror.children.first {
                return Mirror(reflecting: child.value).children.first?.value
            } else {
                return nil
            }
        } else {
            return mirror.children.first?.value
        }
    }
}
