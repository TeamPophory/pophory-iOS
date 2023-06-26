//
//  UIImageView+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UIImageView {
    @IBInspectable var rotateAngle: CGFloat {
        get {
            return atan2(transform.b, transform.a) * (180 / .pi)
        }
        set {
            rotateImage(angle: newValue)
        }
    }
    
    private func rotateImage(angle: CGFloat) {
        transform = transform.rotated(by: .pi / 180 * angle)
    }
}
