//
//  EditAlbumView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import SnapKit

protocol AlbumCoverProfileButtonDidTappedProtocol {
    func albumCoverThemeDidTapped(themeIndex: Int)
}

protocol AlbumCoverEditButtonDidTappedProtocol {
    func editButtonDidTapped()
}

final class EditAlbumView: UIView {
    
    var albumCoverProfileButtonDidTappedProtocol: AlbumCoverProfileButtonDidTappedProtocol?
    var albumCoverEditButtonDidTappedProtocol: AlbumCoverEditButtonDidTappedProtocol?
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    
    private lazy var albumCoverProfile1 = createAlbumCoverProfileButton(image: AlbumData.albumCoverImages[0])
    private lazy var albumCoverProfile2 = createAlbumCoverProfileButton(image: AlbumData.albumCoverImages[1])
    private lazy var albumCoverProfile3 = createAlbumCoverProfileButton(image: AlbumData.albumCoverImages[2])
    private lazy var albumCoverProfile4 = createAlbumCoverProfileButton(image: AlbumData.albumCoverImages[3])
    private let albumCoverProfileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 18
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var albumCoverCollectionView: UICollectionView = {
        let flowLayout = HorizontalCarouselCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 45)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 280 * 375 / UIScreen.main.bounds.width, height: 380 * 375 / UIScreen.main.bounds.width)
        
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
        setButtonTarget()
        handleEditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubviews(
            [
                lineView,
                albumCoverProfileStackView,
                albumCoverCollectionView,
                editButton
            ]
        )
        
        albumCoverProfileStackView.addArrangedSubviews(
            [
                albumCoverProfile1,
                albumCoverProfile2,
                albumCoverProfile3,
                albumCoverProfile4
            ]
        )
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        albumCoverProfileStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(UIScreen.main.hasNotch ? 52 : 20)
            $0.centerX.equalToSuperview()
        }
        
        albumCoverCollectionView.snp.makeConstraints {
            $0.top.equalTo(albumCoverProfile1.snp.bottom).offset(UIScreen.main.hasNotch ? 53 : 10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }
        
        editButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(43)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
    
    private func createAlbumCoverProfileButton(
        image: UIImage
    ) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        return button
    }
    
    private func setButtonTarget() {
        albumCoverProfile1.tag = 0
        albumCoverProfile2.tag = 1
        albumCoverProfile3.tag = 2
        albumCoverProfile4.tag = 3
        
        albumCoverProfile1.addTarget(self, action: #selector(albumCoverButtonDidTapped(_:)), for: .touchUpInside)
        albumCoverProfile2.addTarget(self, action: #selector(albumCoverButtonDidTapped(_:)), for: .touchUpInside)
        albumCoverProfile3.addTarget(self, action: #selector(albumCoverButtonDidTapped(_:)), for: .touchUpInside)
        albumCoverProfile4.addTarget(self, action: #selector(albumCoverButtonDidTapped(_:)), for: .touchUpInside)
    }

    @objc
    func albumCoverButtonDidTapped(_ sender: UIButton) {
        for (index, button) in [albumCoverProfile1, albumCoverProfile2, albumCoverProfile3, albumCoverProfile4].enumerated() {
            if button == sender {
                button.setImage(AlbumData.albumCoverAlphaImages[index], for: .normal)
                self.albumCoverProfileButtonDidTappedProtocol?.albumCoverThemeDidTapped(themeIndex: index)
            } else {
                button.setImage(AlbumData.albumCoverImages[index], for: .normal)
            }
        }
    }
    
    @objc
    func editButtonTapped() {
        albumCoverEditButtonDidTappedProtocol?.editButtonDidTapped()
    }
    
    func setAlbumCoverProfileImage(
        albumCoverIndex: Int
    ) {
        switch albumCoverIndex {
        case 0:
            albumCoverProfile1.setImage(AlbumData.albumCoverAlphaImages[0], for: .normal)
            albumCoverProfile2.setImage(AlbumData.albumCoverImages[1], for: .normal)
            albumCoverProfile3.setImage(AlbumData.albumCoverImages[2], for: .normal)
            albumCoverProfile4.setImage(AlbumData.albumCoverImages[3], for: .normal)
        case 1:
            albumCoverProfile1.setImage(AlbumData.albumCoverImages[0], for: .normal)
            albumCoverProfile2.setImage(AlbumData.albumCoverAlphaImages[1], for: .normal)
            albumCoverProfile3.setImage(AlbumData.albumCoverImages[2], for: .normal)
            albumCoverProfile4.setImage(AlbumData.albumCoverImages[3], for: .normal)
        case 2:
            albumCoverProfile1.setImage(AlbumData.albumCoverImages[0], for: .normal)
            albumCoverProfile2.setImage(AlbumData.albumCoverImages[1], for: .normal)
            albumCoverProfile3.setImage(AlbumData.albumCoverAlphaImages[2], for: .normal)
            albumCoverProfile4.setImage(AlbumData.albumCoverImages[3], for: .normal)
        case 3:
            albumCoverProfile1.setImage(AlbumData.albumCoverImages[0], for: .normal)
            albumCoverProfile2.setImage(AlbumData.albumCoverImages[1], for: .normal)
            albumCoverProfile3.setImage(AlbumData.albumCoverImages[2], for: .normal)
            albumCoverProfile4.setImage(AlbumData.albumCoverAlphaImages[3], for: .normal)
        default: return
        }
    }
}

extension EditAlbumView {
    private func handleEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}
