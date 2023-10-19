//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by 김다예 on 2023/09/27.
//

import UIKit
import Social
import UniformTypeIdentifiers

final class ShareViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first else {
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
            return
        }
        handleIncomingText(itemProvider: itemProvider)
    }

    private func handleIncomingText(itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: UIImage.self) { // itemProvider가 불러온 이미지 값 가져올 수 있다면 실행
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                self.extensionContext?.completeRequest(returningItems: nil) { _ in
                    guard let url = URL(string: "pophoryiOS://share") else { return }

                    self.openURL(url)
                    UIPasteboard.general.image = image as? UIImage
                }
            }
        }
    }

    @objc
    @discardableResult
    func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }
}
