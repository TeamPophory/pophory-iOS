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
    var albumCoverIndex = Int()
    var albumThemeCoverIndex: Int? {
        didSet {
            guard let albumThemeCoverIndex = albumThemeCoverIndex else { return }
            editAlbumView.setAlbumCoverProfileImage(albumCoverIndex: albumThemeCoverIndex)
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
        editAlbumView.albumCoverEditButtonDidTappedProtocol = self
        
        editAlbumView.albumCoverCollectionView.dataSource = self
        editAlbumView.albumCoverCollectionView.delegate = self
    }
    
    private func setCollectionView() {
        editAlbumView.albumCoverCollectionView.register(cell: AlbumCoverCollectionViewCell.self)
    }
    
    override func viewDidLayoutSubviews() {
        setAlbumCover(albumIndex: albumCoverIndex)
    }
    
    private func setAlbumCover(albumIndex: Int) {
        let indexPath = IndexPath(item: albumIndex, section: 0)
        self.editAlbumView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension EditAlbumViewController: AlbumCoverProfileButtonDidTappedProtocol {
    func albumCoverThemeDidTapped(themeIndex: Int) {
        let albumCoverIndex = themeIndex * 2
        let indexPath = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension EditAlbumViewController: AlbumCoverEditButtonDidTappedProtocol {
    func editButtonDidTapped() {
        // MARK: - 앨범 변경 인덱스, albumCoverIndex
    }
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

extension EditAlbumViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(self.editAlbumView.albumCoverCollectionView.contentOffset.x / (self.editAlbumView.albumCoverCollectionView.frame.width - 110))
        self.albumCoverIndex = currentIndex
        self.albumThemeCoverIndex = currentIndex / 2
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}
