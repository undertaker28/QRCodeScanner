//
//  ScannerViewModel.swift
//  QRCodeScanner
//
//  Created by Pavel on 15.08.23.
//

import Foundation
import SwiftyUserDefaults

final class ScannerViewModel: ObservableObject {
    @Published private var recentList: [ScannedObject] = []
    
    func addToRecentList(scannedObject: ScannedObject, removeDuplicate: Bool) {
        if let historyList = Defaults.historyList {
            if removeDuplicate && (historyList.filter{ $0.data == scannedObject.data }.count > 0) {
                return
            }
            self.recentList = historyList
            self.recentList.append(scannedObject)
            Defaults.historyList?.append(scannedObject)
        } else {
            self.recentList = [scannedObject]
            Defaults.historyList = [scannedObject]
        }
    }
    
    func checkIfVibrate() -> Bool {
        Defaults.vibrate
    }
    
    func checkIfCopyByDefault() -> Bool {
        Defaults.copyResultToClipboard
    }
    
    func checkIfBrowseByDefault() -> Bool {
        Defaults.scanAndBrowser
    }
    
    func checkIfSaveToRecentList() -> Bool {
        Defaults.saveToHistory
    }
    
    func checkIfRemoveDuplicate() -> Bool {
        Defaults.disableDuplicates
    }
}
