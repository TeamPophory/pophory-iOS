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
        networkManager.requestMyPageData(version: 2) { [weak self] profileImageUrl, photoCount in
            self?.rootView.updateProfileImage(profileImageUrl)
            self?.rootView.updatePhotoCount(photoCount)
        }
    }
}

extension MypageViewController: MyPageRootViewDelegate {
    func handleOnclickSetting() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    func handleOnClickShare() {
        navigationController?.pushViewController(SharePhotoViewController(), animated: true)
    }
    
    func handleOnClickStory() {
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/porit-story", title: "포릿 이야기")
        navigationController?.pushViewController(vc, animated: true)
    }
}
