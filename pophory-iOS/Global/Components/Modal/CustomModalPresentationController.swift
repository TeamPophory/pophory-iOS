//
//  CustomModalPresentationController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

/**
 생성 예시
 
 let customModalVC = CalendarModalViewController()
 customModalVC.modalPresentationStyle = .custom

 let customTransitionDelegate = CustomModalTransitionDelegate(customHeight: 360)
 customModalVC.transitioningDelegate = customTransitionDelegate

 present(customModalVC, animated: true, completion: nil)
 **/

class CustomModalPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    private let customHeight: CGFloat
    
    // MARK: - UI Properties
    
    private let dimmendView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryBlack
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(presentedViewController: UIViewController, presenting
         presentingViewController: UIViewController?, customHeight: CGFloat) {
        self.customHeight = customHeight
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupTapGesture()
    }
    
    // MARK: - override
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return CGRect.zero }
        let safeAreaInsets = containerView.safeAreaInsets
        let height = customHeight + safeAreaInsets.top + safeAreaInsets.bottom
        
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        dimmendView.alpha = 0
        containerView.addSubview(dimmendView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in self.dimmendView.alpha = 0.3},completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in self.dimmendView.alpha = 0}, completion: { _ in self.dimmendView.removeFromSuperview()})
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.layer.cornerRadius = 20.0
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // 모달의 크기가 조절됐을 때 호출
    override func containerViewDidLayoutSubviews() {
        guard let containerView else { return }
        super.containerViewDidLayoutSubviews()
        dimmendView.frame = containerView.bounds
    }
}

extension CustomModalPresentationController {
    
    // MARK: - @objc
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        dimmendView.addGestureRecognizer(tapGestureRecognizer)
    }
}
