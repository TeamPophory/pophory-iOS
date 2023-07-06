//
//  AddPhotoViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

protocol DateDataBind: AnyObject{
    func dateDataBind(text: String)
}

protocol StudioDataBind: AnyObject{
    func studioDataBind(text: String)
}

final class AddPhotoViewController: BaseViewController, Navigatable {

    // MARK: - Properties
    
    var navigationBarTitleText: String? { return "사진 추가" }
    
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
                rootView.albumCollectionView.reloadData()
        }
    }
    
    // MARK: - UI Properties
    
    private let rootView = AddPhotoView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
        requestGetAlumListAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTarget()
        setupDelegate()
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
    
    @objc func onclickFriendsButton() {
        print("친구")
    }

    // MARK: - Private Methods
    
    private func setupTarget() {
        rootView.dateStackView.infoButton.addTarget(self, action: #selector(onclickDateButton), for: .touchUpInside)
        rootView.studioStackView.infoButton.addTarget(self, action: #selector(onclicStudioButton), for: .touchUpInside)
        rootView.friendsStackView.infoButton.addTarget(self, action: #selector(onclickFriendsButton), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        rootView.albumCollectionView.dataSource = self
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
        } else {
            cell.configureCell(image: UIImage())
        }
        return cell
    }
}

// MARK: - DataBind Protocol

extension AddPhotoViewController: DateDataBind, StudioDataBind {
    
    func dateDataBind(text: String) {
        rootView.dateStackView.setupExplain(explain: text)
        rootView.dateStackView.setupSelected(selected: true)
    }
    
    func studioDataBind(text: String) {
        rootView.studioStackView.setupExplain(explain: text)
        rootView.studioStackView.setupSelected(selected: true)
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
}
