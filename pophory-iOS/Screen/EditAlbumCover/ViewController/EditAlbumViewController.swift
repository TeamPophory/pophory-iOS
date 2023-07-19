//
//  EditAlbumViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import RxSwift

final class EditAlbumViewController: BaseViewController {
    
    private let albumCount: Int = 4
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
        return AlbumData.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCoverCollectionViewCell", for: indexPath) as? AlbumCoverCollectionViewCell else { return UICollectionViewCell()
        }
        let imageData = [ ImageLiterals.albumCover1,
                          ImageLiterals.albumCover2,
                          ImageLiterals.albumCover3,
                          ImageLiterals.albumCover4 ]
        cell.configCell(albumCoverImage: imageData[indexPath.row])
        return cell
    }
}
