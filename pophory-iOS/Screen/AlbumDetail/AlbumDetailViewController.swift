//
//  AlbumDetailViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

@frozen
enum PhotoCellType {
    case vertical
    case horizontal
}

@frozen
enum PhotoSortStyle {
    case current
    case old
}

final class AlbumDetailViewController: BaseViewController {
    
    private let homeAlbumView = AlbumDetailView()
    private var albumPhotoList: PatchAlbumPhotoListResponseDTO? {
        didSet {
            guard let albumPhotoList = albumPhotoList else { return }
            albumPhotoDataSource.update(photos: albumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList.photos.isEmpty)
            homeAlbumView.photoCollectionView.reloadData()
        }
    }
    private lazy var albumPhotoDataSource = PhotoCollectionViewDataSource(collectionView: homeAlbumView.photoCollectionView)
    
    private let albumId: Int = 0
    private var photoSortStyle: PhotoSortStyle = .current {
        didSet {
            guard let albumPhotoList = albumPhotoList else { return }
            let photoAlbumPhotoList = self.sortPhoto(
                albumPhotoList: albumPhotoList,
                sortStyle: photoSortStyle
            )
            albumPhotoDataSource.update(photos: photoAlbumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList.photos.isEmpty)
            homeAlbumView.photoCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = homeAlbumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAction()
        addDelegate()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetAlbumPhotoList(albumId: albumId)
    }
    
    private func setButtonAction() {
        homeAlbumView.sortButton.addTarget(self, action: #selector(sortButtonDidTapped), for: .touchUpInside)
    }
    
    private func presentChangeSortViewController() {
        let changeSortViewController = ChangeSortViewController(
            photoSortStyle: self.photoSortStyle
        )
        changeSortViewController.modalPresentationStyle = .custom
        
        let transitionDelegate = CustomModalTransitionDelegate(customHeight: 138)
        changeSortViewController.transitioningDelegate = transitionDelegate
        changeSortViewController.configPhotoSortSyleDelegate = self
        self.present(changeSortViewController, animated: true)
    }

    private func checkPhotoCellType(
        width: Int,
        height: Int
    ) -> PhotoCellType {
        if width < height {
            return .vertical
        } else {
            return .horizontal
        }
    }
    
    private func sortPhoto(
        albumPhotoList: PatchAlbumPhotoListResponseDTO,
        sortStyle: PhotoSortStyle
    ) -> PatchAlbumPhotoListResponseDTO {
        switch sortStyle {
        case .current:
            return albumPhotoList
        case .old:
            let reversedPhotos = albumPhotoList.photos.reversed()
            return PatchAlbumPhotoListResponseDTO(photos: Array(reversedPhotos))
        }
    }
    
    private func addDelegate() {
        homeAlbumView.photoCollectionView.delegate = self
    }
}

// MARK: - @objc

extension AlbumDetailViewController {
    @objc
    private func sortButtonDidTapped() {
        self.presentChangeSortViewController()
    }
}

// MARK: - delegate

extension AlbumDetailViewController: ConfigPhotoSortStyleDelegate {
    func configPhotoSortStyle(by sortStyle: PhotoSortStyle) {
        self.photoSortStyle = sortStyle
    }
}

// MARK: - collection cell size

extension AlbumDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellIndex = indexPath.row
        guard let photo = albumPhotoList?.photos[cellIndex] else { return CGSize() }
        let photoCellType = checkPhotoCellType(width: photo.width, height: photo.height)
        
        switch photoCellType {
        case .vertical:
            return CGSize(width: (collectionView.bounds.width - 8) / 2, height: 246)
        case .horizontal:
            return CGSize(width: collectionView.bounds.width - 8, height: 223)
        }
    }
}

// MARK: - api

extension AlbumDetailViewController {
    func requestGetAlbumPhotoList(
        albumId: Int
    ) {
        NetworkService.shared.albumRepository.patchAlbumPhotoList(
            albumId: albumId
        ) { result in
            switch result {
            case .success(let response):
                self.albumPhotoList = response
            default : return
            }
        }
    }
}

// MARK: - navigation bar

extension AlbumDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 앨범" }
}
