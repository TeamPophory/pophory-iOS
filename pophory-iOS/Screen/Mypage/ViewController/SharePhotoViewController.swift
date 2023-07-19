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
        
        requestData()
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
        networkManager.requestAllPhoto() { [weak self] photoData in
            self?.networkManager.requestAllPhoto { photoData in
                guard let photoData = photoData else { return }
                self?.rootView.updatePhotoData(photoData)
            }
        }
    }
}

// MARK: - navigation bar

extension SharePhotoViewController: Navigatable {
    var navigationBarTitleText: String? { "네컷사진 공유하기" }
}
