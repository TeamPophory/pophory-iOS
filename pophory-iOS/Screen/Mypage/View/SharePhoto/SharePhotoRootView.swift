//
//  SharePhotoRootView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/15.
//

import UIKit

import SkeletonView
import SnapKit

class SharePhotoRootView: UIView {
    
    // MARK: - Properties
    
    var photoData: [PhotoUrlResponseDto]?
    private var selectedPhotoIndex: Int?
    
    // MARK: - UI Properties
    
    private lazy var emptyStackView: UIStackView = { createEmptyStackView() }()
    private lazy var emptyImageView: UIImageView = { UIImageView(image: ImageLiterals.emptyFeedIcon) }()
    private lazy var emptyDescriptionLabel: UILabel = { createEmptyDescriptionLabel() }()
    private lazy var feedCollectionView: UICollectionView = { createFeedCollectionView() }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePhotoData(_ photoData: [PhotoUrlResponseDto]) {
        self.photoData = photoData
        
        if photoData.isEmpty {
            feedCollectionView.isHidden = true
        } else {
            feedCollectionView.isHidden = false
            feedCollectionView.reloadData()
            feedCollectionView.hideSkeleton()
        }
    }
}

extension SharePhotoRootView {
    private func setupLayout() {
        addSubviews([
            emptyStackView,
            feedCollectionView
        ])
        
        emptyStackView.addArrangedSubviews([
            emptyImageView,
            emptyDescriptionLabel
        ])
        
        emptyStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }

        emptyImageView.snp.makeConstraints { make in
            make.size.equalTo(180)
        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func createFeedTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .h2
        label.text = "네컷사진 모아보기"
        
        return label
    }
    
    private func createEmptyStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        return stackView
    }
    
    private func createEmptyDescriptionLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .h3
        label.textColor = .pophoryGray500
        label.text = "네컷 사진을 추가해볼까?"
        
        return label
    }
    
    private func createFeedCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 30, right: 0)
        
        collectionView.backgroundColor = .pophoryWhite
        
        collectionView.register(cell: PhotoCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showAnimatedGradientSkeleton()
        
        return collectionView
    }
    
    // TODO: 이거 VC로 옮기기 (리팩토링 필요)
    private func sharePhoto(shareId: String) {
        let parentVC = getParentViewController()
        
        let activityVC = UIActivityViewController(activityItems: [shareId], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = parentVC?.view
        
        parentVC?.present(activityVC, animated: true)
        
        activityVC.completionWithItemsHandler = { _, _, _, _ in
            self.deselectPhoto()
        }
    }
    
    private func deselectPhoto() {
        guard let index = selectedPhotoIndex else { return }
        
        feedCollectionView.deselectItem(at: IndexPath(item: index, section: 0), animated: false)
        selectedPhotoIndex = nil
    }
}

extension SharePhotoRootView: SkeletonCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell,
              let photoData = photoData,
              let photoUrl = photoData[indexPath.item].photoUrl else {
            return UICollectionViewCell()
        }
        
        cell.configCell(imageUrl: photoUrl, cellType: .myPage)
        cell.photoMetaData = photoData[indexPath.item]
        cell.clipsToBounds = true
        cell.contentView.isSkeletonable = true
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UICollectionView.automaticNumberOfSkeletonItems
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return PhotoCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        skeletonView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)
    }
}

extension SharePhotoRootView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 4) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else { return }
        
        selectedPhotoIndex = indexPath.item
        
        if let shareId = selectedCell.photoMetaData?.shareId {
            sharePhoto(shareId: shareId)
        }
    }
}
