//
//  UIImage+Extension.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/08/19.
//

import UIKit

extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> CGFloat {

        guard let data = self.pngData() else {
            return 0.0
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = CGFloat(data.count)
        case .kilobyte:
            size = CGFloat(data.count) / 1024
        case .megabyte:
            size = CGFloat(data.count) / 1024 / 1024
        case .gigabyte:
            size = CGFloat(data.count) / 1024 / 1024 / 1024
        }

        return size
    }
}
