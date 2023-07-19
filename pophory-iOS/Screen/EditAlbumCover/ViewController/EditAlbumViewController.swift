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
    var albumCoverIndex: Int? {
        didSet {
            guard let albumCoverIndex = albumCoverIndex else { return }
            editAlbumView.setAlbumCoverProfileImage(albumCoverIndex: albumCoverIndex)
        }
    }
    
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
        editAlbumView.albumCoverProfileButtonDidTappedProtocol = self
        
        editAlbumView.albumCoverCollectionView.dataSource = self
//        editAlbumView.albumCoverCollectionView.delegate = self
    }
    
    private func setCollectionView() {
        editAlbumView.albumCoverCollectionView.register(cell: AlbumCoverCollectionViewCell.self)
    }
}

extension EditAlbumViewController: AlbumCoverProfileButtonDidTappedProtocol {
    func albumCoverThemeDidTapped(themeIndex: Int) {
        let albumCoverIndex = themeIndex * 2
        let indexPath = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}

extension EditAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AlbumData.albumCovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCoverCollectionViewCell", for: indexPath) as? AlbumCoverCollectionViewCell else { return UICollectionViewCell()
        }
        cell.configCell(albumCoverImage: AlbumData.albumCovers[indexPath.row])
        return cell
    }
}
