//
//  HomeAlbumViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

final class HomeAlbumViewController: BaseViewController {
    
    private let progressBackgroundViewWidth: CGFloat = UIScreen.main.bounds.width - 180
    private var albumId: Int?
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            if let albums = albumList?.albums {
                if albums.count != 0 {
                    self.albumId = albums[0].id
                    let albumCover: Int = albums[0].albumCover ?? 0
                    let photoCount: Int = albums[0].photoCount ?? 0
                    
                    // MARK: - update UI
                    homeAlbumView.albumImageView.image = ImageLiterals.albumCoverList[albumCover]
                    homeAlbumView.statusLabelText = String(photoCount)
                    let progressValue = Int(round(progressBackgroundViewWidth * (Double(photoCount) / 15.0)))
                    homeAlbumView.updateProgressBarWidth(updateWidth: progressValue)
                }
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
        homeAlbumView.homeAlbumViewButtonTappedDelegate = self
    }
}

extension HomeAlbumViewController: ImageViewDidTappedProtocol {
    func imageDidTapped() {
        let albumDetailViewController = AlbumDetailViewController()
        if let albumId = self.albumId {
            albumDetailViewController.albumId = albumId
        }
        self.navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
}

extension HomeAlbumViewController: HomeAlbumViewButtonTappedProtocol {
    func elbumCoverEditButtonDidTapped() {
        // MARK: - button tapped
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
