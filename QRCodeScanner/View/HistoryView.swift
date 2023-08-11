//
//  HistoryView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyViewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(historyViewModel.recentList) { data in
                    HistoryRow(scannedObject: data, historyViewModel: self.historyViewModel)
                }
            }
            .onAppear {
                self.historyViewModel.fetchRecentList()
            }
            .navigationBarTitle("Recent")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
