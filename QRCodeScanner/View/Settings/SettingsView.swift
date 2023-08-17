//
//  SettingsView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("activeIcon") private var activeAppIcon: String = "AppIcon"
    @AppStorage("activeColor") private var activeAppMainColor: String = "Blue"
    @ObservedObject private var settingsViewModel = SettingsViewModel()
    let icons = Constants.icons
    let namesOfIcons = Constants.namesOfIcons
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Scanner").font(Font.custom(Constants.Fonts.Bold, size: 20))) {
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
                    .font(Font.custom(Constants.Fonts.Regular, size: 16))
                    .padding(6)
                    
                    Section(header: Text("Appearance").font(Font.custom(Constants.Fonts.Bold, size: 20))) {
                        Picker(selection: $activeAppIcon) {
                            ForEach(0..<icons.count) { index in
                                HStack {
                                    Image(icons[index] + "-Preview")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    Text(namesOfIcons[index])
                                }
                                .tag(icons[index])
                            }
                        } label: {
                            Text("Icon")
                        }
                        .pickerStyle(.navigationLink)
                    }
                    .onChange(of: activeAppIcon, perform: { newValue in
                        let index = icons.firstIndex(of: newValue) ?? 0
                        activeAppMainColor = namesOfIcons[index]
                        UIApplication.shared.setAlternateIconName(newValue)
                    })
                    .font(Font.custom(Constants.Fonts.Regular, size: 16))
                    .padding(6)
                }
                .listStyle(.insetGrouped)
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
