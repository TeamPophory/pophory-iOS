//
//  KeyboardManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

final class KeyboardManager: NSObject {
    weak var bottomConstraint: NSLayoutConstraint?
    weak var viewController: UIViewController?

    init(bottomConstraint: NSLayoutConstraint?, viewController: UIViewController?) {
        self.bottomConstraint = bottomConstraint
        self.viewController = viewController
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let buttonBottomConstraints = 18
            
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - (self.viewController?.view.safeAreaInsets.bottom ?? 0)
            
            self.bottomConstraint?.constant = -1 * keyboardHeight - CGFloat(buttonBottomConstraints)
            self.viewController?.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint?.constant = 0
        self.viewController?.view.layoutIfNeeded()
    }

    func keyboardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func keyboardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
