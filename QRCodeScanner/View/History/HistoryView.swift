//
//  HistoryView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject private var historyViewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(historyViewModel.recentList) { data in
                    HistoryRow(scannedObject: data, historyViewModel: historyViewModel)
                }
                .toolbar {
                    Button(action: {
                        historyViewModel.deleteRecentList()
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                historyViewModel.fetchRecentList()
            }
            .navigationBarTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
