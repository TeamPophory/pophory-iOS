//
//  HomeAlbumViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

protocol AlbumStatusProtocol: AnyObject {
    func isAblumFull(isFull: Bool)
}

final class HomeAlbumViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var albumStatusDelegate: AlbumStatusProtocol?
    
    private let progressBackgroundViewWidth: CGFloat = UIScreen.main.bounds.width - 180
    private var albumId: Int?
    private var maxPhotoLimit: Int?
    private var progressValue: Int?
    private var albumCoverId: Int? {
        didSet {
            guard let albumCoverId = albumCoverId else { return }
            homeAlbumView.albumImageView.image = AlbumData.albumCovers[albumCoverId-1]
        }
    }
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            if let albums = albumList?.albums {
                if albums.count != 0 {
                    self.albumId = albums[0].id
                    self.albumCoverId = albums[0].albumCover
                    let albumCover: Int = albums[0].albumCover ?? 0
                    let photoCount: Int = albums[0].photoCount ?? 0
                    self.maxPhotoLimit = albums[0].photoLimit ?? 0
                    // MARK: - update UI
                    
                    guard let maxPhotoLimit = self.maxPhotoLimit else { return }
                    homeAlbumView.setMaxPhotoCount(maxPhotoLimit)
                    homeAlbumView.albumImageView.image = ImageLiterals.albumCoverList[albumCover]
                    homeAlbumView.statusLabelText = String(photoCount)
                    
                    if maxPhotoLimit == 30 {
                        progressValue = Int(round(progressBackgroundViewWidth * (Double(photoCount) / 30.0)))
                    } else {
                        progressValue = Int(round(progressBackgroundViewWidth * (Double(photoCount) / 15.0)))
                    }
                    if let progress = progressValue {
                        homeAlbumView.updateProgressBarWidth(updateWidth: progressValue ?? 00)
                    }
                    let isAlbumFull = (photoCount == maxPhotoLimit) ? true : false
                    homeAlbumView.updateProgressBarIcon(isAlbumFull: isAlbumFull)
                    albumStatusDelegate?.isAblumFull(isFull: isAlbumFull)
                }
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = homeAlbumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestGetAlumListAPI()
        hideNavigationBar()
    }
}

// MARK: - Extensions

extension HomeAlbumViewController {
    private func setupDelegate() {
        homeAlbumView.imageDidTappedDelegate = self
        homeAlbumView.homeAlbumViewButtonTappedDelegate = self
    }
}

// MARK: - ImageViewDidTappedProtocol

extension HomeAlbumViewController: ImageViewDidTappedProtocol {
    func imageDidTapped() {
        let albumDetailViewController = AlbumDetailViewController()
        if let albumId = self.albumId {
            albumDetailViewController.albumId = albumId
            albumDetailViewController.setupPhotoLimit(maxPhotoLimit ?? 0)
        }
        self.navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
}

//MARK: - HomeAlbumViewButtonTappedProtocol

extension HomeAlbumViewController: HomeAlbumViewButtonTappedProtocol {
    func albumCoverEditButtonDidTapped() {
        let editAlbumViewController = EditAlbumViewController()
        if let albumCoverId = self.albumCoverId {
            editAlbumViewController.albumPK = albumId ?? Int()
            editAlbumViewController.albumCoverIndex = albumCoverId - 1
            editAlbumViewController.albumThemeCoverIndex = albumCoverId / 2
        }
        self.navigationController?.pushViewController(editAlbumViewController, animated: true)
    }
}

// MARK: - Network

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
