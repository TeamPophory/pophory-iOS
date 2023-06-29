//
//  UIStackView+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    func addArrangedSubviews<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addArrangedSubview($0) }
        closure?(subviews)
        return subviews
    }
    
    var edgeInsets: UIEdgeInsets {
        get {
            return self.layoutMargins
        }
        set {
            self.layoutMargins = newValue
            self.isLayoutMarginsRelativeArrangement = true
        }
    }
}
