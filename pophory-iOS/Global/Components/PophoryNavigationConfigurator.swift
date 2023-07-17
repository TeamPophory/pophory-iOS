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
 
 * rightButton 없을 때:
 setupNavigationBar(with: PophoryNavigationConfigurator.shared)
 * rightButton 있을 때:
 PophoryNavigationConfigurator.shared.configureNavigationBar(in: self, navigationController: navigationController!, rightButtonImageType: .plus)
 }
 */

import UIKit

protocol NavigationConfigurator {
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController?, showRightButton: Bool, rightButtonImageType: PophoryNavigationConfigurator.RightButtonImageType?)
}

final class PophoryNavigationConfigurator: NavigationConfigurator {
    
    static let shared = PophoryNavigationConfigurator()
    
    enum RightButtonImageType {
        case plus
        case delete
    }
    
    private init() {}
    
    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController? = nil, showRightButton: Bool = false, rightButtonImageType: RightButtonImageType? = nil) {
        guard let navigationController = navigationController as? PophoryNavigationController else {
            return
        }
        
        navigationController.configureNavigationBar()
        
        if let rightButtonImageType = rightButtonImageType {
            let rightButton: UIBarButtonItem
            
            switch rightButtonImageType {
            case .plus:
                rightButton = UIBarButtonItem(image: ImageLiterals.myAlbumPlusButtonIcon, style: .plain, target: viewController, action: #selector(AlbumDetailViewController.addPhotoButtonOnClick))
            case .delete:
                rightButton = UIBarButtonItem(image: ImageLiterals.trashCanIcon, style: .plain, target: viewController, action: #selector(PhotoDetailViewController.rightButtonOnClick))
            }
            
            viewController.navigationItem.rightBarButtonItem = rightButton
            viewController.navigationItem.rightBarButtonItem?.tintColor = .pophoryBlack
        }
        
        let backBarButton = UIBarButtonItem(image: ImageLiterals.backButtonIcon, style: .plain, target: viewController, action: #selector(BaseViewController.backButtonOnClick))
        viewController.navigationItem.leftBarButtonItem = backBarButton
        viewController.navigationItem.leftBarButtonItem?.tintColor = .pophoryBlack
        
        let titleText = (viewController as? Navigatable)?.navigationBarTitleText ?? viewController.title ?? ""
        viewController.title = titleText
    }
}
