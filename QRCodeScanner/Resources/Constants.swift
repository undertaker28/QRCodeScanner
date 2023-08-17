//
//  Constants.swift
//  QRCodeScanner
//
//  Created by Pavel on 16.08.23.
//

import Foundation

struct Constants {
    static let icons = ["AppIcon", "AppIcon1", "AppIcon2", "AppIcon3", "AppIcon4"]
    static let namesOfIcons = ["Blue", "Green", "Orange", "Purple", "Black"]
    
    enum Permission: String {
        case idle = "Not Determined"
        case approved = "Access Granted"
        case denied = "Access Denied"
    }
    
    struct Fonts {
        static let ExtraBold = "Nunito-ExtraBold"
        static let Regular = "Nunito-Regular"
        static let Light = "Nunito-Light"
    }
}
