//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct ContentView: View {
    @State private var defaultTab = 1
    
    var body: some View {
        TabView(selection: $defaultTab) {
            ScannerView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
                .tag(1)
            
            ScannerView()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("Generate")
                }
                .tag(2)
            
            ScannerView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Recent")
                }
                .tag(3)
            
            ScannerView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(Color("Blue"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
