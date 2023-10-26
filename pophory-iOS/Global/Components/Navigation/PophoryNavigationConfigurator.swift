//
//  PophoryNavigationConfigurator.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

protocol NavigationConfigurator {
    func configureNavigationBar(in viewController: UIViewController, showRightButton: Bool, rightButtonImageType: PophoryNavigationConfigurator.RightButtonImageType?)
}

// FIXME: 다른파일에서 관리해야할까요..?
protocol ShareButtonDisplayable {
    var shouldDisplayShareButton: Bool { get }
}

final class PophoryNavigationConfigurator: NavigationConfigurator {
    
    static let shared = PophoryNavigationConfigurator()
    
    enum RightButtonImageType {
        case plus
        case delete
        case setting
        case share
    }
    
    private init() {}
    
    func configureNavigationBar(in viewController: UIViewController, showRightButton: Bool = false, rightButtonImageType: RightButtonImageType? = nil) {
        guard let navigationController = viewController.navigationController as? PophoryNavigationController else {
            return
        }
        
        navigationController.configureNavigationBar()
        
        if let rightButtonImageType = rightButtonImageType {
            var rightButtons: [UIBarButtonItem] = []
            
            if showRightButton {
                if rightButtonImageType == .delete {
                    let deleteButton = UIBarButtonItem(image: ImageLiterals.trashCanIcon, style: .plain, target: viewController, action: #selector(PhotoDetailViewController.deleteButtonOnClick))
                    rightButtons.append(deleteButton)
                    
                    if (viewController as? ShareButtonDisplayable)?.shouldDisplayShareButton == true {
                        let shareButton = UIBarButtonItem(image: ImageLiterals.shareIcon, style: .plain, target: viewController, action: #selector(PhotoDetailViewController.shareButtonOnClick))
                        rightButtons.append(shareButton)
                    }
                } else {
                    switch rightButtonImageType {
                    case .plus:
                        let plusButton = UIBarButtonItem(image: ImageLiterals.myAlbumPlusButtonIcon, style: .plain, target: viewController, action: #selector(AlbumDetailViewController.addPhotoButtonOnClick))
                        rightButtons.append(plusButton)
                    case .setting:
                        let settingButton = UIBarButtonItem(image: ImageLiterals.settingIcon, style: .plain, target: viewController, action: #selector(BaseViewController.rightButtonOnClick))
                        rightButtons.append(settingButton)
                    default:
                        break
                    }
                }
            }
            
            if !rightButtons.isEmpty {
                viewController.navigationItem.rightBarButtonItems = rightButtons
                viewController.navigationItem.rightBarButtonItems?.forEach { $0.tintColor = .pophoryBlack }
            } else {
                viewController.navigationItem.rightBarButtonItems = nil
            }
        }
        
        let backButtonAction: Selector = (viewController is QRScannerViewController)
                ? #selector(QRScannerViewController.dismissQrScanner)
                : #selector(BaseViewController.backButtonOnClick)
            let backButton = UIBarButtonItem(image: ImageLiterals.backButtonIcon, style: .plain, target: viewController, action: backButtonAction)
        viewController.navigationItem.leftBarButtonItem = backButton
        viewController.navigationItem.leftBarButtonItem?.tintColor = .pophoryBlack
        
        let titleText = (viewController as? Navigatable)?.navigationBarTitleText ?? viewController.title ?? ""
        viewController.title = titleText
    }
}

extension ShareButtonDisplayable where Self: UIViewController {
    var shouldDisplayShareButton: Bool {
        return self is PhotoDetailViewController
    }
}
