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

final class AlbumDetailViewController: BaseViewController {
    
    private let homeAlbumView = AlbumDetailView()
    private var albumPhotoList: PatchAlbumPhotoListResponseDTO? {
        didSet {
            albumPhotoDataSource.update(photos: albumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList?.photos.isEmpty ?? Bool())
            homeAlbumView.photoCollectionView.reloadData()
        }
    }
    private lazy var albumPhotoDataSource = PhotoCollectionViewDataSource(collectionView: homeAlbumView.photoCollectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAction()
        addDelegate()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func loadView() {
        view = homeAlbumView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetAlbumPhotoList(albumId: 0)
    }
    
    private func setButtonAction() {
        homeAlbumView.sortButton.addTarget(self, action: #selector(sortButtonDidTapped), for: .touchUpInside)
    }
    
    @objc
    private func sortButtonDidTapped() {
        self.presentChangeSortViewController()
    }
    
    private func presentChangeSortViewController() {
        let changeSortViewController = ChangeSortViewController()
        changeSortViewController.modalPresentationStyle = .automatic

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
    
    private func addDelegate() {
        homeAlbumView.photoCollectionView.delegate = self
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
