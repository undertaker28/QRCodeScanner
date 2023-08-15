//
//  HistoryViewModel.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import Foundation
import SwiftyUserDefaults

final class HistoryViewModel: ObservableObject {
    @Published var recentList: [ScannedObject] = []
    
    func fetchRecentList() {
        recentList.removeAll()
        
        if let historyList = Defaults.historyList {
            recentList = historyList
        } else {
            recentList = []
        }
    }
    
    func deleteRecentItem(scannedObject: ScannedObject) {
        let remainingList = recentList.filter { $0.id != scannedObject.id }
        recentList = remainingList
        Defaults.historyList = remainingList
    }
    
    func deleteRecentList() {
        recentList.removeAll()
        Defaults.historyList = []
    }
}
