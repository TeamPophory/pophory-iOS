//
//  EditAlbumViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import GoogleMobileAds
import AdSupport

final class EditAlbumViewController: BaseViewController {
    
    private let editAlbumView = EditAlbumView()
    private var rewardedInterstitialAd: GADRewardedInterstitialAd?
    var albumPK = Int()
    var albumCoverIndex = Int()
    var albumThemeCoverIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
        showNavigationBar()
        setDelegate()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAd()
    }
    
    override func viewDidLayoutSubviews() {
        self.setupViewConstraints(editAlbumView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let albumCoverIndex = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: albumCoverIndex, at: .centeredHorizontally, animated: true)
    }
    
    private func setDelegate() {
        editAlbumView.albumCoverEditButtonDidTappedProtocol = self
        
        editAlbumView.albumCoverCollectionView.dataSource = self
        editAlbumView.albumCoverCollectionView.delegate = self
        
        editAlbumView.albumThemeCollectionView.dataSource = self
        editAlbumView.albumThemeCollectionView.delegate = self
    }
    
    private func setCollectionView() {
        editAlbumView.albumCoverCollectionView.register(cell: AlbumCoverCollectionViewCell.self)
        editAlbumView.albumThemeCollectionView.register(cell: AlbumThemeCollectionViewCell.self)
    }
    
    private func handleAlbumThemeImage(_ index: IndexPath) {
        for i in editAlbumView.albumThemeCollectionView.indexPathsForVisibleItems {
            if i != index {
                guard let cell = editAlbumView.albumThemeCollectionView.cellForItem(at: i) as? AlbumThemeCollectionViewCell else {
                    return
                }
                cell.setClickedState(false)
            }
        }
        
        guard let cell = editAlbumView.albumThemeCollectionView.cellForItem(at: index) as? AlbumThemeCollectionViewCell else {
            return
        }
        cell.setClickedState(true)
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
            firstButtonHandler: pushToFullAd,
            secondButtonHandler: dismissPopUp
        )
    }
}

extension EditAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == editAlbumView.albumThemeCollectionView {
            return AlbumData.albumThemeImages.count
        }
        return AlbumData.albumCovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == editAlbumView.albumThemeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumThemeCollectionViewCell.identifier, for: indexPath) as? AlbumThemeCollectionViewCell else {
                return UICollectionViewCell()
            }
            if indexPath.item == self.albumThemeCoverIndex { cell.setClickedState(true) }
            cell.configCell(indexPath)
            return cell
        } else if collectionView == editAlbumView.albumCoverCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCoverCollectionViewCell.identifier, for: indexPath) as? AlbumCoverCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configCell(albumCoverImage: AlbumData.albumCovers[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension EditAlbumViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let leftInset: CGFloat = 45
        let cellWidth: CGFloat = 280 * UIScreen.main.bounds.width / 375
        let minimumLineSpacing: CGFloat = 16
        let currentIndex = Int((scrollView.contentOffset.x + leftInset) / (cellWidth + minimumLineSpacing))
        
        self.albumCoverIndex = currentIndex
        self.albumThemeCoverIndex = albumCoverIndex / 2
    }
    
    /// 직접 제스처로 scroll한 경우
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = IndexPath(item: albumThemeCoverIndex, section: 0)
        handleAlbumThemeImage(index)
    }
    
    /// scrollToItem을 사용하여 이동한 경우
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = IndexPath(item: albumThemeCoverIndex, section: 0)
        handleAlbumThemeImage(index)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumCoverIndex = indexPath.row * 2
        let albumIndexPath = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: albumIndexPath, at: .centeredHorizontally, animated: true)
        self.albumCoverIndex = albumCoverIndex
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}

// MARK: - Ad
extension EditAlbumViewController {
    private func loadAd() {
        let request = GADRequest()
        guard let UnitAdID = Bundle.main.infoDictionary?["UNIT_AD_ID"] as? String else {
            fatalError("🚨UNIT AD ID을 찾을 수 없습니다🚨")
        }
        
        print("🍥🍥🍥\(UnitAdID)")
        if Bundle.main.infoDictionary?["GADApplicationIdentifier"] is String {
            GADRewardedInterstitialAd.load(withAdUnitID: UnitAdID,
                                           request: request) { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                rewardedInterstitialAd = ad
                rewardedInterstitialAd?.fullScreenContentDelegate = self
            }
        }
    }
    
    private func pushToFullAd() {
        guard let rewardedInterstitialAd = self.rewardedInterstitialAd else {
            print("광고가 준비되지 않았습니다.")
            
            //TODO: - 광고 준비되지 않았을 때 홈으로 돌아가는 상태
            dismiss(animated: true) {
                self.presentAdAndPatchAlbumCover()
            }
            return
        }
        
        dismiss(animated: true) {
            rewardedInterstitialAd.present(fromRootViewController: self) {
                self.presentAdAndPatchAlbumCover()
            }
        }
    }
    
    private func dismissPopUp() {
        dismiss(animated: false)
    }
}

extension EditAlbumViewController: GADFullScreenContentDelegate {
    /// 전면광고 노출 실패 시 호출
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
        print(error.localizedDescription)
    }
    
    /// 전면광고 노출 전 호출
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// 전면광고 종료 후 호출
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
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
    
    private func presentAdAndPatchAlbumCover() {
        let patchAlbumCoverRequestDTO = patchAlbumCoverRequestDTO(albumDesignId: self.albumCoverIndex + 1)
        self.patchAlbumCover(albumId: self.albumPK, body: patchAlbumCoverRequestDTO)
    }
}
