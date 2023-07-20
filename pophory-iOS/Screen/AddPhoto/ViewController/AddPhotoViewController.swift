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
    
    private var presignedURL: PatchPresignedURLRequestDTO?
    private let networkManager = AddPhotoNetworkManager()
    
    private var albumID: Int?
    private var photoCount: Int?
    private let maxPhotoCount: Int = 15
    
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            rootView.albumCollectionView.reloadData()
            if let albums = albumList?.albums {
                if albums.count != 0 {
                    self.albumID = albums[0].id
                    self.photoCount = albums[0].photoCount
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
        networkManager.requestGetAlumListAPI() { [weak self] albumList in
            self?.albumList = albumList
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTarget()
        setupDelegate()
        networkManager.requestGetPresignedURLAPI() { [weak self] presignedURL in
            self?.presignedURL = presignedURL
        }
    }
}

extension AddPhotoViewController {
    
    // MARK: - @objc
    
    @objc func onclickDateButton() {
        let customModalVC = CalendarModalViewController()
        customModalVC.modalPresentationStyle = .custom
        
        let customTransitionDelegate = CustomModalTransitionDelegate(customHeight: 340)
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
        if let photoCount = photoCount {
            if photoCount >= maxPhotoCount {
                showPopup(popupType: .simple,
                          image: ImageLiterals.img_albumfull,
                          primaryText: "포포리 앨범이 가득찼어요",
                          secondaryText: "아쉽지만,\n다음 업데이트에서 만나요!", firstButtonHandler: goToHome)
            } else {
                if let urlString = presignedURL?.presignedUrl, let url = URL(string: urlString) {
                    networkManager.uploadImageToPresignedURL(image: photoImage, presignedURL: url, completion: {_ in
                    })
                } else {
                    print("Invalid URL")
                }
                let photoInfo = PostPhotoS3RequestDTO(fileName: presignedURL?.fileName, albumId: albumID, takenAt: dateTaken, studioId: studioID, width: Int(photoImage.size.width), height: Int(photoImage.size.height))
                networkManager.requestPostPhotoAPI(photoInfo: photoInfo) {
                    self.goToHome()
                }
            }
        }
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
    
    private func goToHome() {
        dismiss(animated: false)
        navigationController?.popViewController(animated: true)
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
