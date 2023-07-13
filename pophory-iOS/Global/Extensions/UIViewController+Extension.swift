//
//  UIViewController+Extension.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/02.
//

import UIKit

extension UIViewController {
    
    var totalNavigationBarHeight: CGFloat {
            let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
            let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
            return navigationBarHeight + statusBarHeight
        }

    
    func setupNavigationBar(with navigationConfigurator: PophoryNavigationConfigurator) {
        if let navigationController = navigationController {
            navigationConfigurator.configureNavigationBar(in: self, navigationController: navigationController, showRightButton: false)
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
}
