//
//  CustomModalPresentationController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

class CustomModalPresentationController: UIPresentationController {
    
    let customHeight: CGFloat
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect.zero
        }

        let safeAreaInsets = containerView.safeAreaInsets
        let height = customHeight + safeAreaInsets.top + safeAreaInsets.bottom
        
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, customHeight: CGFloat) {
        self.customHeight = customHeight
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
}
