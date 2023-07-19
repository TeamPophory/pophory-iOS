//
//  EditAlbumViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import RxSwift

final class EditAlbumViewController: BaseViewController {
    
    private let editAlbumView = EditAlbumView()
    
    override func setupLayout() {
        view = editAlbumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PophoryNavigationConfigurator.shared.configureNavigationBar(in: self, navigationController: navigationController!, rightButtonImageType: .none)
        showNavigationBar()
        setDelegate()
        setCollectionView()
    }
    
    private func setDelegate() {
        editAlbumView.albumCoverCollectionView.dataSource = self
    }
    
    private func setCollectionView() {
        editAlbumView.albumCoverCollectionView.register(cell: AlbumCoverCollectionViewCell.self)
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}

extension EditAlbumViewController: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCoverCollectionViewCell", for: indexPath) as? AlbumCoverCollectionViewCell else { return UICollectionViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.configCell(albumCoverImage: ImageLiterals.albumCover1)
        case 1:
            cell.configCell(albumCoverImage: ImageLiterals.albumCover2)
        case 2:
            cell.configCell(albumCoverImage: ImageLiterals.albumCover3)
        case 3:
            cell.configCell(albumCoverImage: ImageLiterals.albumCover4)
        default:
            return cell
        }
        return cell
    }
}
