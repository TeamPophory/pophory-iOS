//
//  UIButton+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UIButton {
    
    func boldTitle(title: String, size: CGFloat = 16) {
        let attributed = NSMutableAttributedString().bold(title, size: size)
        setAttributedTitle(attributed, for: .normal)
    }

    private func showLoading(_ isLoading: Bool) {
        if isLoading {
            var spinner = UIActivityIndicatorView(frame: bounds)
            
            if let currSpinner = subviews.compactMap({$0 as? UIActivityIndicatorView}).first {
                spinner = currSpinner
            }
            
            spinner.hidesWhenStopped = true
            spinner.color = .black
            
            spinner.startAnimating()
            
            titleLabel?.alpha = 0
            imageView?.alpha = 0
            isEnabled = false
            
            addSubview(spinner)
        } else {
            guard let spinner = subviews.compactMap({$0 as? UIActivityIndicatorView}).first else { return }
            
            spinner.stopAnimating()
            
            titleLabel?.alpha = 1
            imageView?.alpha = 1
            isEnabled = true
            
            spinner.removeFromSuperview()
        }
    }
}

