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
            homeAlbumView.albumImageView.image = AlbumData.albumCovers[albumCoverId - 1]
        }
    }
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: FetchAlbumListResponseDTO? {
        didSet {
            updateUIWithAlbums()
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
    
    deinit {
        tearDownObservers()
    }
}

// MARK: - Extensions

extension HomeAlbumViewController {
    private func setupDelegate() {
        homeAlbumView.imageDidTappedDelegate = self
        homeAlbumView.homeAlbumViewButtonTappedDelegate = self
    }
    
    private func updateUIWithAlbums() {
        guard let album = albumList?.albums?.first else { return }
        
        setupAlbum(album)
        updateUIForAlbum(album)
    }
    
    private func setupAlbum(_ album: Album) {
        self.albumId = album.id
        self.albumCoverId = album.albumCover
        self.maxPhotoLimit = album.photoLimit
        
        progressValue = calculateProgressValue(for: album)
    }
    
    private func updateUIForAlbum(_ album: Album) {
        guard let maxPhotoLimit = self.maxPhotoLimit,
              let progressValueUnwrapped = progressValue else { return }
        
        homeAlbumView.setMaxPhotoCount(maxPhotoLimit)
        
        if let coverIndex = album.albumCover {
            homeAlbumView.albumImageView.image = ImageLiterals.albumCoverList[coverIndex]
        }
        
        homeAlbumView.statusLabelText = String(album.photoCount ?? 0)
        
        homeAlbumView.updateProgressBarWidth(updateWidth: progressValueUnwrapped)
        
        let isFull: Bool = (album.photoCount == maxPhotoLimit)
        
        homeAlbumView.updateProgressBarIcon(isAlbumFull: isFull)
        
        albumStatusDelegate?.isAblumFull(isFull: isFull)
    }
    
    private func calculateProgressValue(for album: Album) -> Int? {
        guard let maxPhotoLimit = self.maxPhotoLimit,
              let photoCount = album.photoCount else { return nil }
        
        return Int(round(progressBackgroundViewWidth * (Double(photoCount) / Double(maxPhotoLimit))))
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
        NetworkService.shared.albumRepository.fetchAlbumList() { result in
            switch result {
            case .success(let response):
                self.albumList = response
            default : return
            }
        }
    }
}
