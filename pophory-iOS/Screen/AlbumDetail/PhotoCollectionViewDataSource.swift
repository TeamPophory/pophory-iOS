//
//  PhotoCollectionViewDataSource.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/05.
//

import UIKit

final class PhotoCollectionViewDataSource {
    
    typealias collectionCell = PhotoCollectionViewCell
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias DiffableSnapshot = NSDiffableDataSourceSnapshot<PhotoCollectionViewDataSource.Section, Int>
    typealias CompletedUpdate = (() -> Void)

    private let collectionView: UICollectionView

    private lazy var dataSource: DiffableDataSource = createDataSource()
    private var albumPhotoList: PatchAlbumPhotoListResponseDTO
    
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
        return UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: collectionView
        ) { [weak self] _, indexPath, _ in
            guard let self = self else {
                return UICollectionViewCell()
            }
            let photo = albumPhotoList.photos[indexPath.row]
            let cell:collectionCell = self.collectionView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.photoImageString = photo.imageUrl
            return cell
        }
    }

    func update(
        photos: PatchAlbumPhotoListResponseDTO?,
        completion: CompletedUpdate? = nil
    ) {
        guard let photos = photos else {
            completion?()
            return
        }
        let itemIdentifiers = photos.photos.compactMap { $0.id }
        self.albumPhotoList = photos
        
        dataSource = createDataSource()
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
