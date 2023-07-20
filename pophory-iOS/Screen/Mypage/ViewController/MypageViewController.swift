//
//  MypageViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

class MypageViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let rootView = MyPageRootView()
    private let networkManager = MyPageNetworkManager()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
        rootView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
}

extension MypageViewController {
    
    // MARK: - Network
    
    private func requestData() {
        networkManager.requestUserInfo() { [weak self] userInfo in
            self?.rootView.updateNickname(userInfo?.nickname)
            self?.rootView.updateFullName(userInfo?.realName)
            self?.rootView.updateProfileImage(userInfo?.profileImageUrl)
        }
        
        networkManager.requestAlbumData() { [weak self] albumList, photoCount in
            self?.rootView.updatePhotoCount(photoCount)
            
            self?.networkManager.requestPhotoData(albumList: albumList) { photoUrlList in
                DispatchQueue.main.async {
                    self?.rootView.updatePhotoData(photoUrlList)
                }
            }
        }
    }
}

extension MypageViewController: MyPageRootViewDelegate {
    func handleOnclickSetting() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
