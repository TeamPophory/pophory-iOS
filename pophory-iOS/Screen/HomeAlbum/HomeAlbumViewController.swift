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
                    let isAlbumFull = (photoCount == 15) ? true : false
                    homeAlbumView.updateProgressBarIcon(isAlbumFull: isAlbumFull)
                    
                    // MARK: - alert
                    
                    if isAlbumFull {
                        showPopup(
                            image: ImageLiterals.img_albumfull,
                            primaryText: "포포리 앨범이 가득찼어요",
                            secondaryText: "아쉬지만,\n다음 업데이트에서 만나요!"
                        )
                    }
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
    func albumCoverEditButtonDidTapped() {
        let editAlbumViewController = EditAlbumViewController()
        self.navigationController?.pushViewController(editAlbumViewController, animated: true)
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
