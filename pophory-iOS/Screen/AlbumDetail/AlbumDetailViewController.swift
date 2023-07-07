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
    case none
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
        }
    }
    private lazy var albumPhotoDataSource = PhotoCollectionViewDataSource(collectionView: homeAlbumView.photoCollectionView)
    
    private let albumId: Int = 12
    private var photoSortStyle: PhotoSortStyle = .current {
        didSet {
            switch photoSortStyle {
            case .current:
                homeAlbumView.setSortLabelText(sortStyleText: "최근에 찍은 순")
            case .old:
                homeAlbumView.setSortLabelText(sortStyleText: "과거에 찍은 순")
            }
            
            guard let albumPhotoList = albumPhotoList else { return }
            let photoAlbumPhotoList = self.sortPhoto(
                albumPhotoList: albumPhotoList
            )
            self.albumPhotoList = photoAlbumPhotoList
            albumPhotoDataSource.update(photos: photoAlbumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList.photos.isEmpty)
        }
    }
    private var uniquePhotoStartId: Int?
    
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
        } else if width > height {
            return .horizontal
        } else {
            return .none
        }
    }
    
    private func sortPhoto(
        albumPhotoList: PatchAlbumPhotoListResponseDTO
    ) -> PatchAlbumPhotoListResponseDTO {
            let reversedPhotos = albumPhotoList.photos.reversed()
            return PatchAlbumPhotoListResponseDTO(photos: Array(reversedPhotos))
    }
    
    private func mappedDefaultAlbumPhoto(
        photos: [Photo]
    ) -> [Photo] {
        var photoItems = [Photo]()
        var verticalItemsBuffer = [Photo]()
        guard let uniquePhotoStartId = uniquePhotoStartId else { return [Photo]() }
        var localUniquePhotoStartId = uniquePhotoStartId
        
        for photo in photos {
            switch checkPhotoCellType(width: photo.width, height: photo.height) {
            case .vertical:
                verticalItemsBuffer.append(photo)
                if verticalItemsBuffer.count == 2 {
                    photoItems.append(contentsOf: verticalItemsBuffer)
                    verticalItemsBuffer.removeAll()
                }
            case .horizontal:
                if !verticalItemsBuffer.isEmpty {
                    localUniquePhotoStartId += 1
                    verticalItemsBuffer.append(Photo(id: localUniquePhotoStartId))
                    photoItems.append(contentsOf: verticalItemsBuffer)
                    verticalItemsBuffer.removeAll()
                }
                photoItems.append(photo)
            case .none:
                break
            }
        }
        
        if !verticalItemsBuffer.isEmpty {
            localUniquePhotoStartId += 1
            verticalItemsBuffer.append(Photo(id: localUniquePhotoStartId))
            photoItems.append(contentsOf: verticalItemsBuffer)
        }
        
        return photoItems
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
        case .none:
            return CGSize(width: (collectionView.bounds.width - 8) / 2, height: 246)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailViewController = PhotoDetailViewController()
        guard let photoList = albumPhotoList?.photos else { return }
        let photoType = checkPhotoCellType(width: photoList[indexPath.row].width ,
                                           height: photoList[indexPath.row].height )
        photoDetailViewController.setData(imageUrl: photoList[indexPath.row].imageUrl ,
                                          takenAt: photoList[indexPath.row].takenAt ,
                                          studio: photoList[indexPath.row].studio ,
                                          type: photoType)
        
        navigationController?.pushViewController(photoDetailViewController, animated: true)
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
                self.uniquePhotoStartId = (response.photos.last?.id ?? Int()) + 1
                let mappedDefaultPhotoList = self.mappedDefaultAlbumPhoto(photos: response.photos)
                let mappedDefaultAlbumPhotoListDTO = PatchAlbumPhotoListResponseDTO(photos: mappedDefaultPhotoList)
                self.albumPhotoList = mappedDefaultAlbumPhotoListDTO
            default : return
            }
        }
    }
}

// MARK: - navigation bar

extension AlbumDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 앨범" }
}
