//
//  ShareActivityItemSource.swift
//  QRCodeScanner
//
//  Created by Pavel on 12.08.23.
//

import SwiftUI
import LinkPresentation

struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let text = ""
        let itemSource = ShareActivityItemSource(shareText: text, shareImage: photo)
        
        let activityItems: [Any] = [photo, text, itemSource]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

final class ShareActivityItemSource: NSObject, UIActivityItemSource {
    var shareText: String
    var shareImage: UIImage
    var linkMetaData = LPLinkMetadata()
    
    init(shareText: String, shareImage: UIImage) {
        self.shareText = shareText
        self.shareImage = shareImage
        linkMetaData.title = shareText
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
}
