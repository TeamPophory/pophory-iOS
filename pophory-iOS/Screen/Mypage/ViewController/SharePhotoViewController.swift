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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestDataV2()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(rootView)
        
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
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
    
    private func requestDataV2() {
        networkManager.requestAllPhoto() { [weak self] photoData in
            self?.networkManager.requestAllPhoto { photoData in
                guard let photoUrlList = photoData?.compactMap({ $0.photoUrl }) else { return }
                self?.rootView.updatePhotoData(photoUrlList)
            }
        }
    }
}

// MARK: - navigation bar

extension SharePhotoViewController: Navigatable {
    var navigationBarTitleText: String? { "네컷사진 공유하기" }
}
