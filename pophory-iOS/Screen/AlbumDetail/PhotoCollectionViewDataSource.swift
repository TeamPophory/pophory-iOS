//
//  PhotoCollectionViewDataSource.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/05.
//

import UIKit

final class PhotoCollectionViewDataSource {
    
    typealias collectionCell = PhotoCollectionViewCell
    typealias CellProvider = (UICollectionView, IndexPath, Int) -> UICollectionViewCell?
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<PhotoCollectionViewDataSource.Section, Int>
    typealias CellRegistration<Cell: UICollectionViewCell> = UICollectionView.CellRegistration<Cell, Int>
    typealias CompletedUpdate = (() -> Void)

    private let collectionView: UICollectionView

    private lazy var dataSource: DiffableDataSource = createDataSource()
    private var albumPhotoList: FetchAlbumPhotoListResponseDTO
    
    enum Section {
        case main
    }
    
    init(
        collectionView: UICollectionView
    ) {
        self.collectionView = collectionView
        self.albumPhotoList = .init(photos: [Photo]())
    }
    
    private func createDataSource() -> DiffableDataSource {
        let photoRegistration: CellRegistration<collectionCell> = configureRegistration()
        let cellProvider: CellProvider = { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: photoRegistration,
                for: indexPath,
                item: item
            )
        }
        return UICollectionViewDiffableDataSource<Section, Int> (
            collectionView: collectionView,
            cellProvider: cellProvider
        )
    }
    
    private func configureRegistration<Cell: collectionCell>() -> CellRegistration<Cell> {
        return CellRegistration<Cell> { [weak self] cell, indexPath, _ in
            guard let self = self else { return }
            let photos = albumPhotoList.photos[indexPath.row]
            cell.configCell(imageUrl: photos.imageUrl)
        }
    }

    func update(
        photos: FetchAlbumPhotoListResponseDTO?,
        completion: CompletedUpdate? = nil
    ) {
        guard let photos else {
            completion?()
            return
        }
        let itemIdentifiers = photos.photos.compactMap { $0.id }
        self.albumPhotoList = photos
        
        var snapshot = dataSource.snapshot()
        if snapshot.sectionIdentifiers.contains(Section.main) == false {
            snapshot.appendSections([.main])
        }
        snapshot.appendItems(itemIdentifiers, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true) {
            completion?()
        }
    }
}
