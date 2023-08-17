//
//  AlbumDetailViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit
import Photos

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
    
    private let addPhotoViewController = AddPhotoViewController()
    private let imagePHPViewController = BasePHPickerViewController()
    private let limitedViewController = PHPickerLimitedPhotoViewController()
    private var albumPhotoCount = Int()
    
    private let homeAlbumView = AlbumDetailView()
    private var albumPhotoList: PatchAlbumPhotoListResponseDTO? {
        didSet {
            guard let albumPhotoList = albumPhotoList else { return }
            
            albumPhotoCount = albumPhotoList.photos.filter{$0.imageUrl != ""}.count
            albumPhotoDataSource.update(photos: albumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList.photos.isEmpty)
        }
    }
    private lazy var albumPhotoDataSource = PhotoCollectionViewDataSource(collectionView: homeAlbumView.photoCollectionView)
    
    private var photoSortStyle: PhotoSortStyle = .current {
        didSet {
            switch photoSortStyle {
            case .current:
                homeAlbumView.setSortLabelText(sortStyleText: "최근에 찍은 순")
            case .old:
                homeAlbumView.setSortLabelText(sortStyleText: "과거에 찍은 순")
            }
        }
    }
    private var uniquePhotoStartId: Int?
    var albumId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAction()
        addDelegate()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared, showRightButton: true, rightButtonImageType: .plus)
        
        showNavigationBar()
        
        imagePHPViewController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestGetAlbumPhotoList(albumId: albumId ?? 0)
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(homeAlbumView)
        
        homeAlbumView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func setButtonAction() {
        homeAlbumView.sortButton.addTarget(self, action: #selector(sortButtonDidTapped), for: .touchUpInside)
    }
    
    private func presentChangeSortViewController() {
        let changeSortViewController = ChangeSortViewController(
            photoSortStyle: self.photoSortStyle
        )
        changeSortViewController.modalPresentationStyle = .custom
        
        let transitionDelegate = CustomModalTransitionDelegate(customHeight: UIScreen.main.hasNotch ? 138 : 170)
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
    
    @objc func addPhotoButtonOnClick() {
        if albumPhotoCount >= 15 {
            showPopup(
                image: ImageLiterals.img_albumfull,
                primaryText: "포포리 앨범이 가득찼어요",
                secondaryText: "아쉽지만,\n다음 업데이트에서 만나요!"
            )
        }
        imagePHPViewController.setupImagePermission()
    }
}

// MARK: - delegate

extension AlbumDetailViewController: ConfigPhotoSortStyleDelegate {
    func configPhotoSortStyle(by sortStyle: PhotoSortStyle) {
        if self.photoSortStyle != sortStyle {
            guard let albumPhotoList = self.albumPhotoList else { return }
            let photoAlbumPhotoList = self.sortPhoto(
                albumPhotoList: albumPhotoList
            )
            self.albumPhotoList = photoAlbumPhotoList
            albumPhotoDataSource.update(photos: photoAlbumPhotoList)
            homeAlbumView.setEmptyPhotoExceptionImageView(isEmpty: albumPhotoList.photos.isEmpty)
        }
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
        photoDetailViewController.setData(photoID: photoList[indexPath.row].id,
                                          imageUrl: photoList[indexPath.row].imageUrl ,
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
                let maxId: Int = response.photos.map { $0.id }.max() ?? 0
                self.uniquePhotoStartId = maxId + 1
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

// MARK: - PHPickerProtocol

extension AlbumDetailViewController: PHPickerProtocol {
    
    func setupPicker() {
        DispatchQueue.main.async {
            guard let selectedImage = self.imagePHPViewController.pickerImage else { return }
            
            let secondViewController = AddPhotoViewController()
            
            var imageType: PhotoCellType = .vertical
            
            if selectedImage.size.width > selectedImage.size.height {
                imageType = .horizontal
            } else {
                imageType = .vertical
            }
            
            secondViewController.setupRootViewImage(forImage: selectedImage, forType: imageType)
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func presentLimitedLibrary() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    func presentImageLibrary() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.phpickerViewController, animated: true)
        }
    }
    
    func presentDenidAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.deniedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.limitedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedImageView() {
        DispatchQueue.main.async {
            self.limitedViewController.setImageDummy(forImage: self.imagePHPViewController.fetchLimitedImages())
            self.navigationController?.pushViewController(self.limitedViewController, animated: true)
        }
    }
}
