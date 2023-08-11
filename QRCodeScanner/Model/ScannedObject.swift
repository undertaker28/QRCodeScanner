//
//  ScannedObject.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI
import SwiftyUserDefaults

enum ObjectType: Int, Codable {
    case url
    case text
}

struct ScannedObject: Identifiable, Codable, DefaultsSerializable {
    var id = UUID()
    let data: String
    let scanDate: String?
    let type: ObjectType?
}
