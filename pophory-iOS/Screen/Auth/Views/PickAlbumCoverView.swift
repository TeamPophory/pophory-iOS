//
//  PickAlbumView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

protocol PickAlbumCoverViewDelegate: BaseSignUpViewDelegate {
    func didSelectAlbumButton(at index: Int)
}

// MARK: - PickAlbumCoverView

final class PickAlbumCoverView: BaseSignUpView {
    
    // MARK: - Properties
    
    private var lastSelectedItemIndex: IndexPath? = nil
    
    // MARK: - UI Properties
    
    private let albumCoverView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.albumCover1
        return view
    }()
    
    private lazy var selectButtonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRegister()
        setupLayoutForAlbumCoverView(albumCoverView, topOffset: 51)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumCoverView.shapeWithCustomCorners(topLeftRadius: 3, topRightRadius: 20, bottomLeftRadius: 3, bottomRightRadius: 20)
    }
}

//MARK: - Extensions

extension PickAlbumCoverView {
    
    private func setupRegister() {
        selectButtonCollectionView.register(PickAlbumButtonCollectionViewCell.self, forCellWithReuseIdentifier: PickAlbumButtonCollectionViewCell.identifier)
    }
    
    private func setupLayout() {
        addSubviews([albumCoverView, selectButtonCollectionView])
        
        albumCoverView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(convertByWidthRatio(220))
            $0.height.equalTo(convertByHeightRatio(298))
        }
        
        selectButtonCollectionView.snp.makeConstraints {
            $0.top.equalTo(albumCoverView.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(convertByWidthRatio(254))
            $0.height.equalTo(convertByHeightRatio(50))
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PickAlbumCoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: convertByWidthRatio(50), height: convertByHeightRatio(50))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return convertByWidthRatio(18)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (self.delegate as? PickAlbumCoverViewDelegate)?.didSelectAlbumButton(at: indexPath.item)
        if let lastSelected = lastSelectedItemIndex, let lastSelectedCell = collectionView.cellForItem(at: lastSelected) as? PickAlbumButtonCollectionViewCell {
            lastSelectedCell.isSelectedCell = false
        }
        
        if let currentItem = collectionView.cellForItem(at: indexPath) as? PickAlbumButtonCollectionViewCell {
            currentItem.isSelectedCell = true
        }
        
        lastSelectedItemIndex = indexPath
        albumCoverView.image = ImageLiterals.albumCoverList[indexPath.item + 1]
    }
}

// MARK: - UICollectionViewDataSource

extension PickAlbumCoverView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickAlbumButtonCollectionViewCell.identifier, for: indexPath) as? PickAlbumButtonCollectionViewCell else { return UICollectionViewCell() }
        buttonCell.configureCell(forImage: ImageLiterals.albumCoverProfileList[indexPath.item + 1])
        return buttonCell
    }
}
