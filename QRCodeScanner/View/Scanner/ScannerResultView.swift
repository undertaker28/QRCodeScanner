//
//  ScannerResultView.swift
//  QRCodeScanner
//
//  Created by Pavel on 15.08.23.
//

import SwiftUI

struct ScannerResultView: View {
    var scannedObject: ScannedObject
    var parentView: ScannerView
    var copyDataByDefault: Bool
    var browseByDefault: Bool
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showBrowseButton = false
    @AppStorage("activeColor") private var activeAppMainColor: String = "Blue"
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Text("You can copy the QR information or easily share it with the application you want.")
                    .frame(maxWidth: .infinity, alignment: .top)
                    .foregroundColor(Color("Black"))
                    .font(Font.custom(Constants.Fonts.Regular, size: 15))
                    .padding(30)
                    .multilineTextAlignment(.center)
                VStack {
                    HStack {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25, alignment: .center)
                            .onTapGesture {
                                self.parentView.scannedObject = nil
                            }
                        
                        Spacer()
                        
                        Text(scannedObject.scanDate ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.white)
                            .font(Font.custom(Constants.Fonts.Bold, size: 17))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                    .padding(20)
                    
                    Image(systemName: scannedObject.type == .url ? "link" : "t.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 28, alignment: .center)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    Text(scannedObject.data)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .font(Font.custom(Constants.Fonts.Regular, size: 20))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .minimumScaleFactor(0.5)
                    
                    HStack(spacing: 25) {
                        if self.showBrowseButton {
                            Image(systemName: "safari.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 28, alignment: .center)
                                .onTapGesture {
                                    print("Browse button was tapped")
                                    if let url = URL(string: self.scannedObject.data) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                        }
                        
                        Image(systemName: "square.and.arrow.up.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28, alignment: .center)
                            .onTapGesture {
                                print("Share button was tapped")
                                self.scannedObject.data.actionSheet()
                            }
                        
                        Image(systemName: "doc.on.doc.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 28, alignment: .center)
                            .onTapGesture {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = self.scannedObject.data
                                
                                self.alertMessage = "Text copied to clipboard!"
                                self.showingAlert = true
                            }
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                }
                .background(Color(activeAppMainColor))
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Success"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                }
                .onAppear() {
                    if self.scannedObject.data.isValidURL() {
                        self.showBrowseButton = true
                    }
                    
                    if self.copyDataByDefault {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = self.scannedObject.data
                    }
                    
                    if self.browseByDefault {
                        if let url = URL(string: self.scannedObject.data) {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                }
            }
        }
    }
}

struct ScannerResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerResultView(scannedObject: ScannedObject(data: "http://en.m.wikipedia.org", scanDate: Optional("15.08.2023"), type: Optional(ObjectType.url)), parentView: ScannerView(), copyDataByDefault: false, browseByDefault: false)
    }
}
