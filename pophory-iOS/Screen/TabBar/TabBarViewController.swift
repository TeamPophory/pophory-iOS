//
//  TabBarViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

import Photos
import SnapKit

final class TabBarController: UITabBarController {
    
    // MARK: - viewController properties
    
    private let homeAlbumViewController = HomeAlbumViewController()
    private let plusViewController = UIViewController()
    private let myPageViewController = MypageViewController()
    
    private let addPhotoViewController = AddPhotoViewController()
    private let imagePHPViewController = BasePHPickerViewController()
    private let limitedViewController = PHPickerLimitedPhotoViewController()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setupDelegate()
    }
    
    private func setUpTabBar(){
        self.tabBar.tintColor = .pophoryPurple
        self.tabBar.unselectedItemTintColor = .pophoryGray400
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .pophoryWhite
        
        let imageInset: CGFloat = 10.0
        homeAlbumViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)
        plusViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageViewController.tabBarItem.imageInsets = UIEdgeInsets(top: imageInset, left: 0, bottom: -imageInset, right: 0)
        
        let viewControllers:[UIViewController] = [
            homeAlbumViewController,
            plusViewController,
            myPageViewController
        ]
        self.setViewControllers(viewControllers, animated: true)
        
        homeAlbumViewController.tabBarItem.image = ImageLiterals.tabBarHomeAlbumIcon
        plusViewController.tabBarItem.image = ImageLiterals.tabBarEditAlbumIcon
        myPageViewController.tabBarItem.image = ImageLiterals.tabBarMyPageIcon
        
        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
    
    private func setupDelegate() {
        self.delegate = self
        imagePHPViewController.delegate = self
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == plusViewController {
            imagePHPViewController.setupImagePermission()
            return false
        } else { return true }
    }
}

extension TabBarController: PHPickerProtocol {
    
    func setupPicker() {
        DispatchQueue.main.async {
            guard let selectedImage = self.imagePHPViewController.pickerImage else { return }
            
            let secondViewController = AddPhotoViewController()
            
            var imageType: PhotoCellType = .vertical
            
            if selectedImage.size.width > selectedImage.size.height {
                imageType = .horizontal
            } else {
                imageType = .vertical
            }
            
            secondViewController.setupRootViewImage(forImage: selectedImage, forType: imageType)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func presentLimitedLibrary() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    func presentImageLibrary() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.phpickerViewController, animated: true)
        }
    }
    
    func presentDenidAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.deniedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.limitedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedImageView() {
        DispatchQueue.main.async {
            self.limitedViewController.setImageDummy(forImage: self.imagePHPViewController.fetchLimitedImages())
            self.navigationController?.pushViewController(self.limitedViewController, animated: true)
        }
    }
}
