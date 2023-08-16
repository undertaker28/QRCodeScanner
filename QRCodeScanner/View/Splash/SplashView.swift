//
//  SplashView.swift
//  QRCodeScanner
//
//  Created by Pavel on 12.08.23.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("activeIcon") var activeIcon: String = ""
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            Image(activeIcon + "-Preview")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
