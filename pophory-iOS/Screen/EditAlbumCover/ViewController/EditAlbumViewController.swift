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
    var albumThemeCoverIndex: Int? {
        didSet {
            guard let albumThemeCoverIndex else { return }
            editAlbumView.setAlbumCoverProfileImage(albumCoverIndex: albumThemeCoverIndex)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAd()
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
    
    override func viewDidAppear(_ animated: Bool) {
        let albumCoverIndex = IndexPath(item: albumCoverIndex, section: 0)
        editAlbumView.albumCoverCollectionView.scrollToItem(at: albumCoverIndex, at: .centeredHorizontally, animated: true)
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
            firstButtonHandler: pushToFullAd,
            secondButtonHandler: dismissPopUp
        )
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
        let currentIndex = Int(self.editAlbumView.albumCoverCollectionView.contentOffset.x / (self.editAlbumView.albumCoverCollectionView.frame.width - 95))
        if self.editAlbumView.albumCoverCollectionView.contentOffset.x == 0 {
            self.albumCoverIndex = currentIndex
        } else {
            self.albumCoverIndex = currentIndex + 1
        }
        self.albumThemeCoverIndex = albumCoverIndex / 2
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}

// MARK: - Ad
extension EditAlbumViewController {
    private func loadAd() {
        let request = GADRequest()
        
        if Bundle.main.infoDictionary?["GADApplicationIdentifier"] is String {
            GADRewardedInterstitialAd.load(withAdUnitID: PophoryAdManager.shared.fetchEditAlbumAd() ?? "ca-app-pub-3940256099942544/6978759866",
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
    
    private func presentAdAndPatchAlbumCover() {
        let patchAlbumCoverRequestDTO = patchAlbumCoverRequestDTO(albumDesignId: self.albumCoverIndex + 1)
        self.patchAlbumCover(albumId: self.albumPK, body: patchAlbumCoverRequestDTO)
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
}
