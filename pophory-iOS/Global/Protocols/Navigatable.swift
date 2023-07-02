//
//  Navigatable.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/02.
//

import UIKit

protocol Navigatable {
    var navigationBarTitleText: String? { get }
}

extension Navigatable where Self: UIViewController {
    var navigationBarTitleText: String? {
        return nil
    }
}


