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
    
    // MARK: - Properties
    
    private var isAlbumFull: Bool = false
    
    // MARK: - ViewController properties
    
    private let homeAlbumViewController = HomeAlbumViewController()
    private let plusViewController = UIViewController()
    private let myPageViewController = MypageViewController()
    
    private let addPhotoViewController = AddPhotoViewController()
    private var imagePHPViewController = BasePHPickerViewController()
    private let limitedViewController = PHPickerLimitedPhotoViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShareNetworkManager.shared.requestPostSharePhoto() { [weak self] response in
            if (response?.code == 4423) {
                self?.showPopup(popupType: .simple,
                                secondaryText: "이미 내 앨범에 있는 사진이에요",
                                firstButtonTitle: .back)
            }
            self?.homeAlbumViewController.requestGetAlumListAPI()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(didReceiveUnauthorizedNotification(_:)),
                                               name:.didReceiveUnauthorizedNotification,
                                               object:nil)
        
        setUpTabBar()
        setupDelegate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Extensions

extension TabBarController {
    
    // MARK: - Setups
    
    private func setUpTabBar(){
        self.tabBar.tintColor = .pophoryPurple
        self.tabBar.unselectedItemTintColor = .pophoryGray400
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .pophoryWhite
        
        let imageInset: CGFloat = UIScreen.main.hasNotch ? 10 : 0
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
        homeAlbumViewController.albumStatusDelegate = self
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == plusViewController {
            if isAlbumFull == true {
                showPopup(
                    image: ImageLiterals.img_albumfull,
                    primaryText: "포포리 앨범이 가득찼어요",
                    secondaryText: "아쉽지만,\n다음 업데이트에서 만나요!"
                )
                return  false
            }
            imagePHPViewController.setupImagePermission()
            return false
        } else { return true }
    }
}

extension TabBarController: AlbumStatusProtocol {
    func isAblumFull(isFull: Bool) {
        self.isAlbumFull = isFull
    }
}

// MARK: - PHPickerProtocol

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
            self.imagePHPViewController = BasePHPickerViewController()
            self.imagePHPViewController.delegate = self
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
    
    func presentOverSize() {
        DispatchQueue.main.async {
            self.showPopup(popupType: .simple,
                           secondaryText: "사진의 사이즈가 너무 커서\n업로드할 수 없어요!")
        }
    }
}

// MARK: - Network

extension TabBarController {    
    @objc func didReceiveUnauthorizedNotification(_ notification:NSNotification) {
        refreshToken()
    }
    
    func refreshToken() {
        let authRepository = DefaultAuthRepository()
        
        authRepository.updateRefreshToken { result in
            switch result {
            case .success(let loginResponse):
                guard let loginResponse = loginResponse as? UpdatedAccessTokenDTO else { return }
                PophoryTokenManager.shared.saveAccessToken(loginResponse.accessToken)
                PophoryTokenManager.shared.saveRefreshToken(loginResponse.refreshToken)
            case .requestErr(let message):
                print("Error updating token:\(message)")
            case .networkFail:
                print("Network error")
            default:
                break
            }
        }
    }
}
