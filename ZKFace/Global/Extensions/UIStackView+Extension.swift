//
//  UIStackView+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UIStackView {
    
    @IBInspectable var edgeInsetTop: CGFloat {
        get {
            return self.layoutMargins.top
        }
        set {
            layoutMargins = UIEdgeInsets(top: newValue, left: layoutMargins.left, bottom: layoutMargins.bottom, right: layoutMargins.right)
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    @IBInspectable var edgeInsetLeft: CGFloat {
        get {
            return self.layoutMargins.left
        }
        set {
            layoutMargins = UIEdgeInsets(top: layoutMargins.top, left: newValue, bottom: layoutMargins.bottom, right: layoutMargins.right)
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    @IBInspectable var edgeInsetBottom: CGFloat {
        get {
            return self.layoutMargins.bottom
        }
        set {
            layoutMargins = UIEdgeInsets(top: layoutMargins.top, left: layoutMargins.left, bottom: newValue, right: layoutMargins.right)
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    @IBInspectable var edgeInsetRight: CGFloat {
        get {
            return self.layoutMargins.right
        }
        set {
            layoutMargins = UIEdgeInsets(top: layoutMargins.top, left: layoutMargins.left, bottom: layoutMargins.bottom, right: newValue)
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
}
