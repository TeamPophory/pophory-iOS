//
//  EditAlbumView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import SnapKit

protocol AlbumCoverEditButtonDidTappedProtocol {
    func editButtonDidTapped()
}

final class EditAlbumView: UIView {
    
    var albumCoverEditButtonDidTappedProtocol: AlbumCoverEditButtonDidTappedProtocol?
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    
    private(set) lazy var albumThemeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let itemWidth = 50 * UIScreen.main.bounds.width / 375
        let itemHeight = 50 * UIScreen.main.bounds.height / 812
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        let totalItemWidth = itemWidth * CGFloat(AlbumData.albumThemeImages.count)
        let totalSpacingWidth = UIScreen.main.bounds.width - totalItemWidth - 120
        let minimumLineSpacing = totalSpacingWidth / CGFloat(AlbumData.albumThemeImages.count - 1)
        flowLayout.minimumLineSpacing = minimumLineSpacing

        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private(set) lazy var albumCoverCollectionView: UICollectionView = {
        let flowLayout = HorizontalCarouselCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 45)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 280 * UIScreen.main.bounds.width / 375, height: 380 * UIScreen.main.bounds.height / 812)
        
        let collectionViewLayout: UICollectionViewFlowLayout = flowLayout as UICollectionViewFlowLayout
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.decelerationRate = .fast
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var editButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.edit)
            .build()
        buttonBuilder.applySize()
        return buttonBuilder
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        configUI()
        handleEditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubviews(
            [
                lineView,
                albumThemeCollectionView,
                albumCoverCollectionView,
                editButton
            ]
        )
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        albumThemeCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(UIScreen.main.hasNotch ? 52 : 20)
            $0.centerX.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(60)
            $0.height.equalTo(50 * UIScreen.main.bounds.height / 812)
        }
        
        albumCoverCollectionView.snp.makeConstraints {
            $0.top.equalTo(albumThemeCollectionView.snp.bottom).offset(UIScreen.main.hasNotch ? 53 : 10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(editButton.snp.top).offset(-64)
        }
        
        editButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(43)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
    
    @objc
    func editButtonTapped() {
        albumCoverEditButtonDidTappedProtocol?.editButtonDidTapped()
    }
}

extension EditAlbumView {
    private func handleEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}
