//
//  UIImage+Extension.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/08/19.
//

import UIKit

extension UIImage {
    var megabytesSize: Double {
        if let imageData = self.jpegData(compressionQuality: 0.8) {
            print(imageData)
            let bytesInMB = 1024.0 * 1024.0
            let imageSizeInMB = Double(imageData.count) / bytesInMB
            return imageSizeInMB
        }
        return 0.0
    }
}
