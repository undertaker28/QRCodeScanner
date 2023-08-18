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
                .scrollContentBackground(.hidden)
                .toolbar {
                    Button(action: {
                        historyViewModel.deleteRecentList()
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color("Black"))
                    }
                }
            }
            .onAppear {
                historyViewModel.fetchRecentList()
            }
            .navigationBarTitle("History")
            .background(Color("BackgroundForHistoryAndSettings"))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
