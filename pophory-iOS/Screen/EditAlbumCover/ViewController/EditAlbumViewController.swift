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
    var albumPK = Int()
    var albumCoverIndex = Int()
    var albumThemeCoverIndex: Int? {
        didSet {
            guard let albumThemeCoverIndex = albumThemeCoverIndex else { return }
            editAlbumView.setAlbumCoverProfileImage(albumCoverIndex: albumThemeCoverIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
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
        view.addSubview(editAlbumView)
        
        editAlbumView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
        
        editAlbumView.layoutSubviews()
    }
}

extension EditAlbumViewController: AlbumCoverProfileButtonDidTappedProtocol {
    func albumCoverThemeDidTapped(themeIndex: Int) {
        let albumCoverIndex = themeIndex * 2
        let indexPath = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.albumCoverIndex = albumCoverIndex
    }
}

extension EditAlbumViewController: AlbumCoverEditButtonDidTappedProtocol {
    func editButtonDidTapped() {
        showPopup(
            popupType: .option,
            image: ImageLiterals.adIcon,
            primaryText: "앨범을 수정할까요?",
            secondaryText: "앨범 커버를 수정하려면\n광고 시청 하나 부탁드려요!",
            firstButtonTitle: .keppGoing,
            secondButtonTitle: .back,
            firstButtonHandler: loadAd,
            secondButtonHandler: dismissPopUp
        )
        // TODO: 서버통신 수정
        // 앨범 커버 수정 서버 통신
//        let patchAlbumCoverRequestDTO = patchAlbumCoverRequestDTO(albumDesignId: self.albumCoverIndex + 1)
//        self.patchAlbumCover(albumId: albumPK, body: patchAlbumCoverRequestDTO)
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

// MARK: - api

extension EditAlbumViewController {
    func patchAlbumCover(
        albumId: Int,
        body: patchAlbumCoverRequestDTO
    ) {
        NetworkService.shared.albumRepository.patchAlbumCover(
            albumId: albumId, body: body
        ) { result in
            switch result {
            case .success(_):
                self.navigationController?.popViewController(animated: true)
                return
            default : return
            }
        }
    }
    
    private func loadAd() {
        print("전면광고를 로드합니다.")
    }
    
    private func dismissPopUp() {
        dismiss(animated: false)
    }
}
