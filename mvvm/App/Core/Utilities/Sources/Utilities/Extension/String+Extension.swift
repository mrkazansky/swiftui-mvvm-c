//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import UIKit

extension String {
    public func toDate(_ format: String = "") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        if (format.isEmpty){
            if self.contains(".") {
                // format 2022-07-07T15:26:00.000Z
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            } else if self.contains("Z") {
                // format 2022-07-07T15:26:00Z
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            } else if (self.contains(" ")) {
                // format 2022-07-07 15:26:00Z
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            } else {
                // format 2022-07-07T16:00:00
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            }
        }
        return formatter.date(from: self)
    }
    
    public func htmlAttributedString(font: UIFont) -> NSAttributedString {
        guard let data = self.data(using: .utf8) else {
            return NSAttributedString(string: "")
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let htmlString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            htmlString.addAttribute(.font, value: font, range: NSRange(location: 0, length: htmlString.length))
            return htmlString
        } catch {
            print("Error converting HTML string: \(error.localizedDescription)")
            return NSAttributedString(string: "")
        }
    }
    
    public func localizedString(_ bundle: Bundle = Bundle.main) -> String {
        let localizedString = NSLocalizedString(self, bundle: bundle, comment: "")
        return localizedString
    }
}
