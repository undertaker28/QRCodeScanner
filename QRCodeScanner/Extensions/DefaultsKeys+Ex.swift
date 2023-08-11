//
//  DefaultsKeys+Ex.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    var historyList: DefaultsKey<[ScannedObject]?> { .init("scannedObjects") }
    var vibrate: DefaultsKey<Bool> { .init("vibrate", defaultValue: true) }
    var copyResultToClipboard: DefaultsKey<Bool> { .init("copyResultToClipboard", defaultValue: false) }
    var scanAndBrowser: DefaultsKey<Bool> { .init("scanAndBrowser", defaultValue: false) }
    var saveToHistory: DefaultsKey<Bool> { .init("saveToHistory", defaultValue: true) }
    var disableDuplicates: DefaultsKey<Bool> { .init("disableDuplicates", defaultValue: true) }
}
