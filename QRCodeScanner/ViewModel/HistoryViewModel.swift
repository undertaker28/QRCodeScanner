//
//  HistoryViewModel.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import Foundation
import SwiftUI
import SwiftyUserDefaults
import AVFoundation

final class HistoryViewModel: ObservableObject {
    @Published var recentList: [ScannedObject] = []
    @Published var flashOn: Bool = false
    
    func fetchRecentList() {
        self.recentList.removeAll()
        
        if let historyList = Defaults.historyList {
            self.recentList = historyList
        } else {
            self.recentList = []
        }
    }
    
    func deleteRecentItem(scannedObject: ScannedObject) {
        let remainingList = self.recentList.filter { $0.id != scannedObject.id }
        self.recentList = remainingList
        Defaults.historyList = remainingList
    }
}
