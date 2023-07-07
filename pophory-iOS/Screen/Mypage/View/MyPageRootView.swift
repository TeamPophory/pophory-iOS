//
//  MyPageRootView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/06.
//

import UIKit

import SnapKit

class MyPageRootView: UIView {
    
    // MARK: Properties
    
    private var collectionViewHeight: CGFloat = 0
    
    // MARK: - UI Properties
    
    private lazy var headerStackView: UIStackView = { createHeaderStackView() }()
    private lazy var nicknameLabel: UILabel = { createNicknameLabel() }()
    private lazy var settingButton: UIButton = { createSettingButton() }()
    private lazy var headerBorderView: UIView = { createHeaderBorderView() }()
    
    private lazy var scrollView: UIScrollView = { createScrollView() }()
        private lazy var contentView: UIView = { UIView() }()
    
    private lazy var profileView: UIView = { UIView() }()
    private lazy var profileImageView: UIImageView = { createProfileImageView() }()
    private lazy var profileStackView: UIStackView = { createProfileStackView() }()
    private lazy var profileNameLabel: UILabel = { createProfileNameLabel() }()
    private lazy var photoCountLabel: UILabel = { createPhotoCountLabel() }()
    
    private lazy var feedTitleLabel: UILabel = { createFeedTitleLabel() }()
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
}

extension MyPageRootView {
    
    // MARK: - Layout
    
    private func setupLayout() {
        setupHeaderView()
        setupScrollView()
        setupProfileView()
        // TODO: - 광고 뷰 추가
        setupCollectionView()
    }
    
    private func setupHeaderView() {
        addSubviews([
            headerStackView,
            headerBorderView
        ])
        
        headerStackView.addArrangedSubviews([
            nicknameLabel,
            settingButton
        ])
        
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        headerBorderView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
        }
    }
    
    private func setupProfileView() {
        contentView.addSubview(profileView)
        
        profileView.addSubviews([
            profileImageView,
            profileStackView
        ])
        
        profileStackView.addArrangedSubviews([
            profileNameLabel,
            photoCountLabel
        ])
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(114)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(72)
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileView).inset(20)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.centerY.equalTo(profileImageView)
        }
    }
    
    private func setupCollectionView() {
        contentView.addSubviews([
            feedTitleLabel,
//            emptyStackView,
            feedCollectionView
        ])
        
//        emptyStackView.addArrangedSubviews([
//            emptyImageView,
//            emptyDescriptionLabel
//        ])
        
        feedTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
        }
        
//        emptyStackView.snp.makeConstraints { make in
//            make.top.equalTo(feedTitleLabel.snp.bottom).offset(46)
//            make.centerX.equalToSuperview()
//        }
//
//        emptyImageView.snp.makeConstraints { make in
//            make.size.equalTo(180)
//        }
        
        feedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(feedTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(contentView).inset(20) // here
            make.height.equalTo(1000)
            make.bottom.equalTo(contentView).inset(20) // here
        }
    }
    
    private func createHeaderStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.edgeInsets = UIEdgeInsets(top: 21, left: 20, bottom: 21, right: 20)
        
        return stackView
    }
    
    private func createNicknameLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "@pophory_12345"
        label.font = .h2
        
        return label
    }
    
    private func createSettingButton() -> UIButton {
        let button = UIButton()
        
        button.setImage(ImageLiterals.settingIcon, for: .normal)
        button.tintColor = .pophoryBlack
        
        return button
    }
    
    private func createHeaderBorderView() -> UIView {
        let border = UIView()
        
        border.backgroundColor = .pophoryGray300
        
        return border
    }
    
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    private func createProfileImageView() -> UIImageView {
        let imageView = UIImageView(image: ImageLiterals.defaultProfile)
        
        imageView.makeRounded(radius: 36)
        
        return imageView
    }
    
    private func createProfileStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        
        return stackView
    }
    
    private func createProfileNameLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "한수아"
        label.font = .h3
        
        return label
    }
    
    private func createPhotoCountLabel() -> UILabel {
        let label = UILabel()
        
        label.attributedText = NSMutableAttributedString()
            .regular("그동안 찍은 사진 ", color: .pophoryBlack)
            .regular("0", color: .pophoryPurple)
            .regular("장", color: .pophoryBlack)
        
        return label
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
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(cell: PhotoCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }
}

extension MyPageRootView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.configCell(imageUrl: photo.imageUrl)
        cell.backgroundColor = .blue
        
        return cell
    }
}

extension MyPageRootView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 4) / 3
        return CGSize(width: size, height: size)
    }
}
