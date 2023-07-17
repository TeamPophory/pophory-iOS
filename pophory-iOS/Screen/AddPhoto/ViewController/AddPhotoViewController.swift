//
//  AddPhotoViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

import Moya
import SnapKit

protocol DateDataBind: AnyObject{
    func dateDataBind(text: String, forPost: String)
}

protocol StudioDataBind: AnyObject{
    func studioDataBind(text: String, forIndex: Int)
}

final class AddPhotoViewController: BaseViewController, Navigatable {
    
    // MARK: - Properties
    
    var navigationBarTitleText: String? { return "사진 추가" }
    
    private var albumID: Int?
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            rootView.albumCollectionView.reloadData()
            
            if let albums = albumList?.albums {
                if albums.count != 0 {
                    self.albumID = albums[0].id
                }
            }
        }
    }
    
    private var photoImage = UIImage()
    private var dateTaken: String = DateManager.dateToStringForPOST(date: Date())
    private var studioID: Int = -1
    
    // MARK: - UI Properties
    
    private let rootView = AddPhotoView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showNavigationBar()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
        requestGetAlumListAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTarget()
        setupDelegate()
        requestGetAlumListAPI()
    }
}

extension AddPhotoViewController {
    
    // MARK: - @objc
    
    @objc func onclickDateButton() {
        let customModalVC = CalendarModalViewController()
        customModalVC.modalPresentationStyle = .custom
        
        let customTransitionDelegate = CustomModalTransitionDelegate(customHeight: 326)
        customModalVC.transitioningDelegate = customTransitionDelegate
        customModalVC.delegate = self
        present(customModalVC, animated: true, completion: nil)
    }
    
    @objc func onclicStudioButton() {
        let customModalVC = StudioModalViewController()
        customModalVC.modalPresentationStyle = .custom
        
        let customTransitionDelegate = CustomModalTransitionDelegate(customHeight: 232)
        customModalVC.transitioningDelegate = customTransitionDelegate
        customModalVC.delegate = self
        present(customModalVC, animated: true, completion: nil)
    }

    @objc func onclickAddPhotoButton() {
        guard let multipartData = fetchMultiPartData() else { return }
        requestPostPhotoAPI(photoInfo: multipartData)
    }
    
    // MARK: - Private Methods
    
    private func setupTarget() {
        rootView.dateStackView.infoButton.addTarget(self, action: #selector(onclickDateButton), for: .touchUpInside)
        rootView.studioStackView.infoButton.addTarget(self, action: #selector(onclicStudioButton), for: .touchUpInside)
        rootView.photoAddButton.addTarget(self, action: #selector(onclickAddPhotoButton), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        rootView.albumCollectionView.dataSource = self
    }
    
    private func fetchMultiPartData() -> [MultipartFormData]? {
        if let imageData = photoImage.jpegData(compressionQuality: 0.8) {
            let imageDataProvider = Moya.MultipartFormData(provider: MultipartFormData.FormDataProvider.data(imageData), name: "photo", fileName: "image.jpg", mimeType: "image/jpeg")
            guard let albumId = albumID else { return nil }
            let albumIDDataProvider = Moya.MultipartFormData(provider: .data("\(albumId)".data(using: .utf8) ?? .empty), name: "albumId")
            let dateProvider = Moya.MultipartFormData(provider: .data("\(dateTaken)".data(using: .utf8) ?? .empty), name: "takenAt")
            let studioIDProvider = Moya.MultipartFormData(provider: .data("\(studioID)".data(using: .utf8) ?? .empty), name: "studioId")
            return [imageDataProvider, albumIDDataProvider, dateProvider, studioIDProvider]
        } else { return nil }
    }
    
    // MARK: - Methods
    
    func setupRootViewImage(forImage: UIImage?, forType: PhotoCellType) {
        rootView.photo.image = forImage
        rootView.photoType = forType
        photoImage = forImage ?? UIImage()
    }
}

// MARK: - UICollectionView Delegate

extension AddPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = albumList?.albums?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCollectionViewCell.identifier, for: indexPath) as? PhotoAlbumCollectionViewCell else { return UICollectionViewCell() }
        if let albumCoverInt = albumList?.albums?[indexPath.item].albumCover {
            cell.configureCell(image: ImageLiterals.albumCoverList[albumCoverInt])
        }
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return cell
    }
}

// MARK: - DataBind Protocol

extension AddPhotoViewController: DateDataBind, StudioDataBind {
    
    func dateDataBind(text: String, forPost: String) {
        rootView.dateStackView.setupExplain(explain: text)
        rootView.dateStackView.setupSelected(selected: true)
        dateTaken = forPost
    }
    
    func studioDataBind(text: String, forIndex: Int) {
        rootView.studioStackView.setupExplain(explain: text)
        rootView.studioStackView.setupSelected(selected: true)
        studioID = forIndex
    }
}

// MARK: - API

extension AddPhotoViewController {
    func requestGetAlumListAPI() {
        NetworkService.shared.albumRepository.patchAlbumList() { result in
            switch result {
            case .success(let response):
                self.albumList = response
            default : return
            }
        }
    }
    
    func requestPostPhotoAPI(
        photoInfo: [MultipartFormData]
    ) {
        NetworkService.shared.photoRepository.postPhoto(body: photoInfo
        ) { result in
            switch result {
            case .success(_):
                print("성공")
                self.navigationController?.popViewController(animated: true)
            default : return
            }
        }
    }
}
