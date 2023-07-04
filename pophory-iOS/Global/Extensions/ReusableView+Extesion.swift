//
//  ReusableView+Extesion.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/04.
//

import UIKit.UIView

public protocol ReusableView: AnyObject {}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
