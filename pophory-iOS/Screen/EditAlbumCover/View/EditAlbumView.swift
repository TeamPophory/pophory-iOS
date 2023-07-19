//
//  EditAlbumView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import SnapKit

protocol AlbumCoverButtonDidTappedProtocol {
    func albumCoverProfile1DidTapped()
    func albumCoverProfile2DidTapped()
    func albumCoverProfile3DidTapped()
    func albumCoverProfile4DidTapped()
}

final class EditAlbumView: UIView {
    
    private let screenWidth = UIScreen.main.bounds.width
    var albumCoverButtonDidTappedProtocol: AlbumCoverButtonDidTappedProtocol?

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    private let albumCoverProfile1: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.albumCoverProfile1, for: .normal)
        return button
    }()
    private let albumCoverProfile2: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.albumCoverProfile2, for: .normal)
        return button
    }()
    private let albumCoverProfile3: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.albumCoverProfile3, for: .normal)
        return button
    }()
    private let albumCoverProfile4: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.albumCoverProfile4, for: .normal)
        return button
    }()
    lazy var albumCoverCollectionView: UICollectionView = {
        let flowLayout = HorizontalCarouselCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 45)
        flowLayout.scrollDirection = .horizontal
        let collectionViewLayout: UICollectionViewFlowLayout = flowLayout as UICollectionViewFlowLayout
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.decelerationRate = .fast
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pophoryBlack
        button.setTitle("수정하기", for: .normal)
        button.layer.cornerRadius = 30
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if let flowLayout = albumCoverCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let height = albumCoverCollectionView.frame.height
            flowLayout.itemSize = CGSize(width: height * 280 / 380, height: height)
        }
    }
    
    private func setupLayout() {
        self.addSubviews(
            [
                lineView,
                albumCoverProfile1,
                albumCoverProfile2,
                albumCoverProfile3,
                albumCoverProfile4,
                albumCoverCollectionView,
                editButton
            ]
        )

        lineView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        albumCoverProfile1.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(52)
            $0.leading.equalToSuperview().inset(70)
            $0.size.equalTo(50)
        }
        
        albumCoverProfile2.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(52)
            $0.leading.equalTo(albumCoverProfile1.snp.trailing).offset(18)
            $0.size.equalTo(50)
        }
        
        albumCoverProfile3.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(52)
            $0.leading.equalTo(albumCoverProfile2.snp.trailing).offset(18)
            $0.size.equalTo(50)
        }
        
        albumCoverProfile4.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(52)
            $0.leading.equalTo(albumCoverProfile3.snp.trailing).offset(18)
            $0.size.equalTo(50)
        }
        
        albumCoverCollectionView.snp.makeConstraints {
            $0.top.equalTo(albumCoverProfile1.snp.bottom).offset(53)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }
        
        editButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(43)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
}

extension EditAlbumView {
    @objc
    private func albumCoverProfile1ButtonDidTapped() {
        albumCoverButtonDidTappedProtocol?.albumCoverProfile1DidTapped()
    }
}
