//
//  SettingsView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Scanner").font(Font.custom("MarkPro-Bold", size: 20))) {
                        Toggle("Vibrate", isOn: $settingsViewModel.vibrate)
                            .onTapGesture {
                                self.settingsViewModel.toggleVibrate()
                            }
                        
                        Toggle("Copy to Clipboard", isOn: $settingsViewModel.copyResultToClipboard)
                            .onTapGesture {
                                self.settingsViewModel.toggleCopyResultToClipboard()
                            }
                        
                        Toggle("Scan & Browse if URL", isOn: $settingsViewModel.scanAndBrowser)
                            .onTapGesture {
                                self.settingsViewModel.toggleScanAndBrowser()
                            }
                        
                        Toggle("Save to History", isOn: $settingsViewModel.saveToHistory)
                            .onTapGesture {
                                self.settingsViewModel.toggleSaveToHistory()
                            }
                        
                        Toggle("Remove Duplicate Results", isOn: $settingsViewModel.disableDuplicates)
                            .onTapGesture {
                                self.settingsViewModel.toggleDisableDuplicates()
                            }
                    }
                    .font(Font.custom("MarkPro-Bold", size: 16))
                    .padding(6)
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
