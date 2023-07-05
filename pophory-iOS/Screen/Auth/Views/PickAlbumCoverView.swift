//
//  PickAlbumView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

protocol PickAlbumCoverViewDelegate: AnyObject {
    func didSelectRowAtIndexPath(indexPath: IndexPath)
}

final class PickAlbumCoverView: BaseSignUpView {

    weak var delegate: PickAlbumCoverViewDelegate?
    
    private let albumCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
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

extension PickAlbumCoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: convertByWidthRatio(50), height: convertByHeightRatio(50))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return convertByWidthRatio(18)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAtIndexPath(indexPath: indexPath)
    }
}

extension PickAlbumCoverView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickAlbumButtonCollectionViewCell.identifier, for: indexPath) as? PickAlbumButtonCollectionViewCell else { return UICollectionViewCell() }
        
        return buttonCell
    }
}
