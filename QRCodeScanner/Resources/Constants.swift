//
//  Constants.swift
//  QRCodeScanner
//
//  Created by Pavel on 16.08.23.
//

import Foundation

struct Constants {
    static let icons = ["AppIcon1", "AppIcon2", "AppIcon3", "AppIcon4"]
    static let namesOfIcons = ["Green", "Orange", "Purple", "Blue"]
    
    enum Permission: String {
        case idle = "Not Determined"
        case approved = "Access Granted"
        case denied = "Access Denied"
    }
    
    struct Fonts {
        static let Light = "MarkPro-Light"
        static let Regular = "MarkPro-Regular"
        static let Bold = "MarkPro-Bold"
    }
}
