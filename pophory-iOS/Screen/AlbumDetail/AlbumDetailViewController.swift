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
    
    let homeAlbumView = AlbumDetailView()
    private var albumPhotoList: PatchAlbumPhotoListResponseDTO?
    
    override func viewDidLoad() {
        view = homeAlbumView
        
        setButtonAction()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetAlbumPhotoList(albumId: 12)
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
        changeSortViewController.modalPresentationStyle = .custom
        
        let yOffset: CGFloat = 222
        changeSortViewController.view.frame = CGRect(x: 0, y: yOffset, width: view.frame.width, height: yOffset)
        self.present(changeSortViewController, animated: true)
    }
    
    private func configCollectionCellLayout(
        photoCellType: PhotoCellType
    ) -> UICollectionViewFlowLayout {
        switch photoCellType {
        case .vertical:
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let cellWidth = (UIScreen.main.bounds.width - 50) / 2
            layout.itemSize = CGSize(width: cellWidth, height: 96)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            return layout
            
        case .horizontal:
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let cellWidth = (UIScreen.main.bounds.width - 50) / 2
            layout.itemSize = CGSize(width: cellWidth, height: 96)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            return layout
        }
    }
}

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

extension AlbumDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 앨범" }
}
