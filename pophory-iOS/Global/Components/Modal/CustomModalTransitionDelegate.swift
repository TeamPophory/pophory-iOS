//
//  CustomModalTransitionDelegate.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

class CustomModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - Properties

    private let customHeight: CGFloat
    
    // MARK: - Life Cycle

    init(customHeight: CGFloat) {
        self.customHeight = customHeight
        super.init()
    }
    
    // MARK: - func
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomModalPresentationController(presentedViewController: presented, presenting: presenting, customHeight: customHeight)
        return presentationController
    }
}
