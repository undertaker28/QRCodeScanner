//
//  GenerateViewModel.swift
//  QRCodeScanner
//
//  Created by Pavel on 12.08.23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

final class GenerateViewModel: ObservableObject {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledQrImage = outputImage.transformed(by: transform)
            
            if let cgimg = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
