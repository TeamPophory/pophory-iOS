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
    
    let homeAlbumViewController = HomeAlbumViewController()
    let plusViewController = UIViewController()
    let myPageViewController = MypageViewController()
    
    let addPhotoViewController = AddPhotoViewController()
    let imagePickerViewController = BaseImagePickerViewController()
    
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
        imagePickerViewController.delegate = self
    }
    
    private func setupImagePermission() {
        PHPhotoLibrary.requestAuthorization({ status in
            switch status{
            case .authorized:
                self.presentImage()
            case .denied:
                self.AuthSettingOpen()
            default:
                break
            }
        })
    }
    
    func presentImage() {
        DispatchQueue.main.async {
            self.present(self.imagePickerViewController, animated: true)
        }
    }
    
    func AuthSettingOpen() {
        DispatchQueue.main.async {
            let titleMessage: String = "사진을 업로드하기 위해 설정을 눌러 사진 접근을 허용해주세요"
            let alert = UIAlertController(title: titleMessage, message: nil, preferredStyle: .alert)
            
            let cancle = UIAlertAction(title: "확인", style: .default)
            let confirm = UIAlertAction(title: "설정", style: .default) { (UIAlertAction) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            
            alert.addAction(cancle)
            alert.addAction(confirm)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == plusViewController {
            setupImagePermission()
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

