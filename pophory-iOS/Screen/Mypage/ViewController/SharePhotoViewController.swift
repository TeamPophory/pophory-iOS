//
//  SharePhotoViewController.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/15.
//

import UIKit

class SharePhotoViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let rootView = SharePhotoRootView()
    private let networkManager = MyPageNetworkManager()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
    }
    
}

extension SharePhotoViewController {
    private func requestData() {
        networkManager.requestAlbumData() { [weak self] albumList, photoCount in
            self?.networkManager.requestPhotoData(albumList: albumList) { photoUrlList in
                DispatchQueue.main.async {
                    self?.rootView.updatePhotoData(photoUrlList)
                }
            }
        }
    }
}

// MARK: - navigation bar

extension SharePhotoViewController: Navigatable {
    var navigationBarTitleText: String? { "네컷사진 공유하기" }
}
