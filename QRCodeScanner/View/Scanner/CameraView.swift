//
//  CameraView.swift
//  QRCodeScanner
//
//  Created by Pavel on 15.08.23.
//

import SwiftUI
import AVKit

struct CameraView: UIViewRepresentable {
    private(set) var frameSize: CGSize
    @Binding private(set) var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
