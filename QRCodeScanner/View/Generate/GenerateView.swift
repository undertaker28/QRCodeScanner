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
                VStack(spacing: 7) {
                    Text("Generate QR codes quickly by inputting text.")
                        .font(Font.custom(Constants.Fonts.Light, size: 16))
                    
                    Text("You can tap the code to share it.")
                        .font(Font.custom(Constants.Fonts.Bold, size: 16))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color("Black"))
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                
                TextField("", text: $data, prompt: Text("Text to generate").foregroundColor(Color("Black")))
                    .font(Font.custom(Constants.Fonts.Bold, size: 12))
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
            .background(Color("Background"))
        }
    }
}

struct GenerateView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView()
    }
}
