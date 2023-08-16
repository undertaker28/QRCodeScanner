//
//  ScannerView.swift
//  QRCodeScanner
//
//  Created by Pavel on 11.08.23.
//

import SwiftUI
import AVKit

struct ScannerView: View {
    @ObservedObject private var scannerViewModel = ScannerViewModel()
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Constants.Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var isCheckedCameraPermission: Bool = false
    @State var scannedObject: ScannedObject? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                if scannedObject != nil {
                    ScannerResultView(scannedObject: scannedObject!,
                                      parentView: self,
                                      copyDataByDefault: scannerViewModel.checkIfCopyByDefault(),
                                      browseByDefault: scannerViewModel.checkIfBrowseByDefault())
                    .onDisappear {
                        if !session.isRunning && cameraPermission == .approved {
                            reactivateCamera()
                            activateScannerAnimation()
                        }
                    }
                } else {
                    Text("Place the QR code inside the area")
                        .font(.custom("MarkPro-Bold", size: 20))
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 20)
                    
                    Text("Scanning will start automatically")
                        .font(.custom("MarkPro-Bold", size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer(minLength: 0)
                    
                    GeometryReader {
                        let size = $0.size
                        
                        ZStack {
                            CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                                .scaleEffect(0.97)
                            
                            ForEach(0...4, id: \.self) { index in
                                let rotation = Double(index) * 90
                                
                                RoundedRectangle(cornerRadius: 2, style: .circular)
                                    .trim(from: 0.61, to: 0.64)
                                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(.init(degrees: rotation))
                            }
                        }
                        .frame(width: size.width, height: size.width)
                        .overlay(alignment: .top, content: {
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height: 2.5)
                                .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                                .offset(y: isScanning ? size.width : 0)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 45)
                }
            }
            .padding(15)
            .navigationBarTitle(scannedObject == nil ? "Scanning..." : "Scanning Result", displayMode: .inline)
            .onAppear(perform: checkCameraPermission)
            .alert(errorMessage, isPresented: $showError) {
                if cameraPermission == .denied {
                    Button("Settings") {
                        let settingsString = UIApplication.openSettingsURLString
                        if let settingsURL = URL(string: settingsString) {
                            openURL(settingsURL)
                        }
                    }
                    
                    Button("Cancel", role: .cancel) { }
                }
            }
            .onChange(of: qrDelegate.scannedObject) { newValue in
                if let code = newValue {
                    scannedObject = code
                    if scannerViewModel.checkIfSaveToRecentList() {
                        scannerViewModel.addToRecentList(scannedObject: scannedObject ?? ScannedObject(data: "", scanDate: "", type: .none), removeDuplicate: scannerViewModel.checkIfRemoveDuplicate())
                    }
                    session.stopRunning()
                    deactivateScannerAnimation()
                    qrDelegate.scannedObject = nil
                }
            }
            .onDisappear {
                session.stopRunning()
            }
        }
    }
    
    private func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    private func activateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    private func deactivateScannerAnimation() {
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    private func checkCameraPermission() {
        if !isCheckedCameraPermission {
            Task {
                switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:
                    cameraPermission = .approved
                    setupCamera()
                case .notDetermined:
                    if await AVCaptureDevice.requestAccess(for: .video) {
                        cameraPermission = .approved
                        if session.inputs.isEmpty {
                            setupCamera()
                        } else {
                            reactivateCamera()
                        }
                    } else {
                        cameraPermission = .denied
                        presentError("Please Provide Access to Camera for scanning codes")
                    }
                case .denied, .restricted:
                    cameraPermission = .denied
                    presentError("Please Provide Access to Camera for scanning codes")
                default:
                    break
                }
            }
        }
        isCheckedCameraPermission = true
        reactivateCamera()
    }
    
    private func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Unknown device error")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("Unknown I/O error")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    private func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
