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
    let plusViewController = UIViewController()
    let myPageViewController = MypageViewController()
    
    let addPhotoViewController = AddPhotoViewController()
    let imagePickerViewController = BaseImagePickerViewController()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setuPImagePicker()
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
    
    private func setuPImagePicker() {
        
        if BaseImagePickerViewController.isSourceTypeAvailable(.photoLibrary){
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.delegate = self
            imagePickerViewController.allowsEditing = false
        }
        else {
            print("갤러리사용 불가")
        }
    }
    
    private func setupDelegate() {
        self.delegate = self
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == plusViewController {
            self.present(imagePickerViewController, animated: true)
            return false
        } else { return true }
    }
}

extension TabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var newImage: UIImage? = nil
        var imageType: PhotoCellType = .vertical
        
        if let possibleImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage") ] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage") ] as? UIImage {
            newImage = possibleImage
        }
        
        if let width = newImage?.size.width, let height = newImage?.size.height {
            if width > height {
                imageType = .horizontal
            } else {
                imageType = .vertical
            }
        }
        
        addPhotoViewController.setupRootViewImage(forImage: newImage, forType: imageType)
        self.navigationController?.pushViewController(addPhotoViewController, animated: true)
        picker.dismiss(animated: true)
    }
}
