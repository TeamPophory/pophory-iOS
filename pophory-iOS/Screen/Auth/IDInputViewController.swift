//
//  IDInputViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

final class IDInputViewController: BaseViewController {
    
    // MARK: - UI Components
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    var bottomConstraint: NSLayoutConstraint?
    
    var keyboardManager: KeyboardManager?
    
    lazy var iDInputView: IDInputView = {
        let view = IDInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        iDInputView = IDInputView(frame: self.view.frame)
        self.view = iDInputView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
        setupKeyboardManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardManager?.keyboardRemoveObserver()
    }
    
    deinit {
        keyboardManager?.keyboardRemoveObserver()
        keyboardManager = nil
    }
}

// MARK: - Extension

extension IDInputViewController {
    
    // MARK: - Layout
    
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
            
        self.bottomConstraint = NSLayoutConstraint(item: iDInputView.nextButton, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.bottomConstraint?.isActive = true
    }
    
    // MARK: - objc
    
    // MARK: - Private Functions
    
    private func setupKeyboardManager() {
        keyboardManager = KeyboardManager(bottomConstraint: bottomConstraint, viewController: self)
        keyboardManager?.keyboardAddObserver()
    }
}
