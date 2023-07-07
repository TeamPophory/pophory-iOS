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
    let addPhotoViewController = AddPhotoViewController()
    let myPageViewController = MypageViewController()
    
//    let editAlbumImageView = UIImageView(image: ImageLiterals.tabBarEditAlbumIcon)
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setUpTabBar()
        setView()
    }
    
    private func setView() {
//        view.addSubview(editAlbumImageView)
        
//        editAlbumImageView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview().inset(25)
//        }
    }
    
    private func setUpTabBar(){
        self.tabBar.tintColor = .pophoryPurple
        self.tabBar.unselectedItemTintColor = .pophoryGray400
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .pophoryWhite
        
        let imageInset: CGFloat = 10.0
        homeAlbumViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)
        addPhotoViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)
        
        let viewControllers:[UIViewController] = [
            homeAlbumViewController,
            addPhotoViewController,
            myPageViewController
        ]
        self.setViewControllers(viewControllers, animated: true)
        
        homeAlbumViewController.tabBarItem.image = ImageLiterals.tabBarHomeAlbumIcon
        addPhotoViewController.tabBarItem.image = ImageLiterals.tabBarEditAlbumIcon
        myPageViewController.tabBarItem.image = ImageLiterals.tabBarMyPageIcon
        
        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == addPhotoViewController {
            let presentVC = UIViewController()
            self.present(presentVC, animated: true)
            return false
        } else { return true }
    }
    

}
