//
//  QRScannerDelegate.swift
//  QRCodeScanner
//
//  Created by Pavel on 15.08.23.
//

import SwiftUI
import AVKit

final class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedObject: ScannedObject?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readableObject.stringValue else { return }
            scannedObject = ScannedObject(data: code, scanDate: Date().toString(format: DateFormat.dd_mm_yyyy), type: code.verifyURL() ? .url : .text)
        }
    }
}
