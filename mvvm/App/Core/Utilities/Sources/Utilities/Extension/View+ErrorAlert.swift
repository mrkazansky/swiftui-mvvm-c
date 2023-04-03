//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import SwiftUI

public extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil)) {
            Alert(title: Text(localizedAlertError?.errorDescription ?? ""),
                  message: Text(localizedAlertError?.recoverySuggestion ?? ""),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: Error
    
    var errorDescription: String? {
        "\(type(of: underlyingError))"
    }
    var recoverySuggestion: String? {
        underlyingError.localizedDescription
    }
    
    init?(error: Error?) {
        guard let error = error else { return nil }
        underlyingError = error
    }
}
