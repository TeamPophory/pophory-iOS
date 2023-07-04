//
//  TabBarViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

import SnapKit

final class TabBarController: UITabBarController {
    
    // MARK: - viewController properties
    
    let homeAlbumViewController = HomeAlbumViewController()
    let editAlbumViewController = UIViewController()
    let myPageViewController = MypageViewController()
    
    let editAlbumImageView = UIImageView(image: ImageLiterals.tabBarEditAlbumIcon)
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setView()
    }
    
    private func setView() {
        view.addSubview(editAlbumImageView)
        
        editAlbumImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25)
        }
    }

    private func setUpTabBar(){
        self.tabBar.tintColor = .pophoryPurple
        self.tabBar.unselectedItemTintColor = .pophoryGray400
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .pophoryWhite
        
        let imageInset: CGFloat = 10.0
        homeAlbumViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)
        myPageViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)

        let viewControllers:[UIViewController] = [
            homeAlbumViewController,
            editAlbumViewController,
            myPageViewController
        ]
        self.setViewControllers(viewControllers, animated: true)

        homeAlbumViewController.tabBarItem.image = ImageLiterals.tabBarHomeAlbumIcon
        myPageViewController.tabBarItem.image = ImageLiterals.tabBarMyPageIcon
        
        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
}
