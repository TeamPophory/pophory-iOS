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

protocol NavigationConfigurator {
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController)
    func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool)
}

class PophoryNavigationConfigurator: NavigationConfigurator {
    
    // MARK: - Private Methods
    
    static let shared = PophoryNavigationConfigurator()
    
    private init() {}
    
    let customTitleFont = UIFont.systemFont(ofSize: 22, weight: .bold)
    var customTitleText = String()
    
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController) {
        
        let titleFont = UIFont.h2
        let titleColor = UIColor.black
        let titleText: String?
        
        if let navigatable = viewController as? Navigatable {
            titleText = navigatable.navigationBarTitleText
        } else {
            titleText = viewController.title
        }
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        navigationController.navigationBar.titleTextAttributes = titleAttributes
        
        viewController.navigationItem.title = titleText ?? "NavTitle"
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: viewController, action: #selector(BaseViewController.backButtonOnClick))
        backButton.tintColor = UIColor.white
        //TODO: 에셋 추가 후 등록예정
        navigationController.navigationBar.backIndicatorImage = UIImage(named: "")
        navigationController.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "")
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
    func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool) {
        if showRightButton {
            let rightButton = UIBarButtonItem(title: "", style: .plain, target: viewController, action: #selector(BaseViewController.rightButtonOnClick))
            rightButton.tintColor = UIColor.white
            viewController.navigationItem.rightBarButtonItem = rightButton
        }
    }
}
