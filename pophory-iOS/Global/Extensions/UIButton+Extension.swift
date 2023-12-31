//
//  UIButton+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import Foundation
import UIKit

import RxCocoa
import RxSwift

extension UIButton {
    
    /// 사용 예시:
    /// fooButton.showLoading(true)
    func showLoading(_ isLoading: Bool) {
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
    
    func handleOnClick(handler handleOnclick: @escaping () -> Void, disposeBag: DisposeBag) {
        rx.tap
            .bind {
                handleOnclick()
            }
            .disposed(by: disposeBag)
    }
    
    func removePadding() {
        titleEdgeInsets = UIEdgeInsets(top: .leastNormalMagnitude, left: .leastNormalMagnitude, bottom: .leastNormalMagnitude, right: .leastNormalMagnitude)
        contentEdgeInsets = UIEdgeInsets(top: .leastNormalMagnitude, left: .leastNormalMagnitude, bottom: .leastNormalMagnitude, right: .leastNormalMagnitude)
    }
}

