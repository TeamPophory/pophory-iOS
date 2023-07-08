//
//  HomeAlbumViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

final class HomeAlbumViewController: BaseViewController {
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            if let albumCover = albumList?.albums?[0].albumCover {
                homeAlbumView.albumImageView.image = ImageLiterals.albumCoverList[albumCover]
            }
            if let photoCount = albumList?.albums?[0].photoCount {
                homeAlbumView.statusLabelText = String(photoCount)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetAlumListAPI()
        hideNavigationBar()
    }
    
    override func setupLayout() {
        view = homeAlbumView
    }
    
    private func setDelegate() {
        homeAlbumView.imageDidTappedDelegate = self
    }
}

extension HomeAlbumViewController: ImageViewDidTappedProtocol {
    func imageDidTapped() {
        let albumDetailViewController = AlbumDetailViewController()
        self.navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
}


extension HomeAlbumViewController  {
    func requestGetAlumListAPI() {
        NetworkService.shared.albumRepository.patchAlbumList() { result in
            switch result {
            case .success(let response):
                self.albumList = response
            default : return
            }
        }
    }
}
