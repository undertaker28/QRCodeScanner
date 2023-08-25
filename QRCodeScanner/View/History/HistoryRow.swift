//
//  HistoryRow.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct HistoryRow: View {
    private let scannedObject: ScannedObject?
    private let historyViewModel: HistoryViewModel
    
    init(scannedObject: ScannedObject? = nil, historyViewModel: HistoryViewModel) {
        self.scannedObject = scannedObject
        self.historyViewModel = historyViewModel
    }
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @AppStorage("activeColor") private var activeAppMainColor: String = "Blue"
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: scannedObject?.type == .url ? "link" : "t.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 24, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                
                Text(scannedObject?.scanDate ?? "")
                    .foregroundColor(Color.white)
                    .font(Font.custom(Constants.Fonts.Light, size: 8))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            }
            
            Text(scannedObject?.data ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .font(Font.custom(Constants.Fonts.Regular, size: 14))
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .onTapGesture {
                    print("Will check if data is URL")
                    if self.scannedObject?.type == .url {
                        if let url = URL(string: self.scannedObject!.data){
                            UIApplication.shared.open(url)
                        }
                    }
                }
            
            Image(systemName: "doc.on.doc")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24, alignment: .center)
                .padding(.trailing, 5)
                .onTapGesture {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = self.scannedObject?.data
                    self.alertMessage = "Text copied to clipboard!"
                    self.showingAlert = true
                }
            
            Image(systemName: "trash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                .onTapGesture {
                    print("Delete button was tapped")
                    self.historyViewModel.deleteRecentItem(scannedObject: self.scannedObject ?? ScannedObject(data: "", scanDate: "", type: .none))
                }
        }
        .foregroundColor(.white)
        .frame(height: 60)
        .background(Color(activeAppMainColor))
        .cornerRadius(15)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Success"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct HistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRow(scannedObject: ScannedObject(data: "https://habr.com/ru/articles/453986/", scanDate: "11.08.2023 21:10", type: .url), historyViewModel: HistoryViewModel())
    }
}
