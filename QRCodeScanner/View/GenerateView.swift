//
//  GenerateView.swift
//  QRCodeScanner
//
//  Created by Pavel on 12.08.23.
//

import SwiftUI

struct GenerateView: View {
    @ObservedObject private var generateViewModel = GenerateViewModel()
    @State private var data = ""
    @State private var showShareSheet = false
    @State private var clipboardValue = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("You can create your QR code instantly by entering the text you want in the field below.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color("Black"))
                    .font(Font.custom("MarkPro-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                Text("You can tap the code to share it.")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color("Black"))
                    .font(Font.custom("MarkPro-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                
                TextField("Text to generate", text: $data)
                    .font(Font.custom("MarkPro-Bold", size: 12))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Image(uiImage: generateViewModel.generateQRCode(from: data))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    .onTapGesture {
                        self.showShareSheet = true
                    }
                    .sheet(isPresented: self.$showShareSheet) {
                        ShareSheet(photo: generateViewModel.generateQRCode(from: data))
                    }
                
                Spacer()
            }
            .navigationBarTitle("Generate")
        }
    }
}

struct GenerateView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView()
    }
}
