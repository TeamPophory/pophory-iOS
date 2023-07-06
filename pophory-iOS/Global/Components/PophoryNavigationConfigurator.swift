//
//  PophoryNavigationConfigurator.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

/**
 1. Navigatable 프로토콜 채택
 2. var navigationBarTitleText: String? { return "회원가입" }
 3. viewWillAppear() {
 setupNavigationBar(with: PophoryNavigationConfigurator.shared)
 }
 */

import UIKit

import SnapKit

protocol NavigationConfigurator {
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController)
    func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool)
}

class PophoryNavigationConfigurator: NavigationConfigurator {
    
    // MARK: - Private Methods
    
    static let shared = PophoryNavigationConfigurator()
    
    private weak var navBarView: UIView?
    private weak var backButton: UIButton?
    
    let customTitleFont = UIFont.h2
    var customTitleText = String()
    
    private init() {}
    
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController) {
        
        let titleFont = UIFont.h2
        let titleColor = UIColor.black
        let titleText: String?
        let navBarHeight: CGFloat = 66.0
        
        let navBarView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            navigationController.navigationBar.addSubview(view)
            navigationController.navigationBar.sendSubviewToBack(view)
            return view
        }()
        
        self.navBarView = navBarView
        
        navBarView.snp.makeConstraints {
            $0.height.equalTo(navBarHeight)
            $0.width.equalTo(navigationController.navigationBar)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        if let navigatable = viewController as? Navigatable {
            titleText = navigatable.navigationBarTitleText
        } else {
            titleText = viewController.title
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = titleFont
            label.textColor = titleColor
            label.text = titleText ?? "NavTitle"
            return label
        }()
        
        lazy var backButton: UIButton = {
            let button = UIButton()
            button.setImage(ImageLiterals.backButtonIcon, for: .normal)
            button.addTarget(viewController, action: #selector(BaseViewController.backButtonOnClick), for: .touchUpInside)
            return button
        }()
        
        self.backButton = backButton
        
        navBarView.addSubviews([titleLabel, backButton])
        
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(navBarView)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(24)
        }
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        navigationController.navigationBar.titleTextAttributes = titleAttributes
        
        viewController.navigationItem.title = titleText ?? "NavTitle"
    }
    
    
    func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool) {
        guard let navBarView = self.navBarView else { return }
        
        print("configureRightButton called")
        
        if showRightButton {
            let rightButton: UIButton = {
                let button = UIButton()
                button.setImage(ImageLiterals.backButtonIcon, for: .normal)
                button.addTarget(viewController, action: #selector(BaseViewController.rightButtonOnClick), for: .touchUpInside)
                return button
            }()
            
            navBarView.addSubview(rightButton)
            
            rightButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
                $0.size.equalTo(24)
            }
        } else {
            navBarView.subviews.forEach { button in
                if let button = button as? UIButton, button != backButton {
                    button.removeFromSuperview()
                }
            }
        }
    }
}
