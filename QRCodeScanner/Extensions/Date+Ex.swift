//
//  Date+Ex.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import Foundation

extension Date {
    func toString(format: String, timezoneIdentifier: String? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }
}
