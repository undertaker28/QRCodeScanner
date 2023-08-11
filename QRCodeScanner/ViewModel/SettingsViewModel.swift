//
//  SettingsViewModel.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import Foundation
import SwiftyUserDefaults

final class SettingsViewModel: ObservableObject {
    @Published var vibrate: Bool = Defaults.vibrate
    @Published var copyResultToClipboard: Bool = Defaults.copyResultToClipboard
    @Published var scanAndBrowser: Bool = Defaults.scanAndBrowser
    @Published var saveToHistory: Bool = Defaults.saveToHistory
    @Published var disableDuplicates: Bool = Defaults.disableDuplicates
    
    func toggleVibrate() {
        Defaults.vibrate = !vibrate
        self.vibrate = !vibrate
    }
    
    func toggleCopyResultToClipboard() {
        Defaults.copyResultToClipboard = !copyResultToClipboard
        self.copyResultToClipboard = !copyResultToClipboard
    }
    
    func toggleScanAndBrowser() {
        Defaults.scanAndBrowser = !scanAndBrowser
        self.scanAndBrowser = !scanAndBrowser
    }
    
    func toggleSaveToHistory() {
        Defaults.saveToHistory = !saveToHistory
        self.saveToHistory = !saveToHistory
    }
    
    func toggleDisableDuplicates() {
        Defaults.disableDuplicates = !disableDuplicates
        self.disableDuplicates = !disableDuplicates
    }
}
