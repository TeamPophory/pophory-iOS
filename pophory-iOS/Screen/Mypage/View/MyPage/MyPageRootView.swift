//
//  MyPageRootView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/06.
//

import UIKit

import SkeletonView
import SnapKit

protocol MyPageRootViewDelegate: NSObject {
    func handleOnclickSetting()
    func handleOnClickShare()
    func handleOnClickStory()
    func handleOnAd()
}

class MyPageRootView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: MyPageRootViewDelegate?
    var photoData: [String]?
    
    // MARK: - UI Properties
    
    private lazy var headerStackView: UIStackView = { createHeaderStackView() }()
    private lazy var nicknameLabel: UILabel = { createNicknameLabel() }()
    private lazy var settingButton: UIButton = { createSettingButton() }()
    private lazy var headerBorderView: UIView = { createHeaderBorderView() }()
    
    private lazy var scrollView: UIScrollView = { createScrollView() }()
    private lazy var contentView: UIView = { UIView() }()
    
    private lazy var profileView: UIView = { UIView() }()
    private lazy var profileBgImageView: UIImageView = { createProfileBgImageView() }()
    private lazy var profileImageView: UIImageView = { createProfileImageView() }()
    private lazy var profileStackView: UIStackView = { createProfileStackView() }()
    private lazy var profileNameLabel: UILabel = { createProfileNameLabel() }()
    private lazy var photoCountLabel: UILabel = { createPhotoCountLabel() }()
    
    private lazy var shareBannerView: UIView = { createShareBannerView() }()
    private lazy var storyBannerView: UIView = { createStoryBannerView() }()
    
    private lazy var adView: UIView = { createBannerAdView() }()
    private lazy var adEmptyView: UIImageView = { UIImageView(image: ImageLiterals.bannerAd) }()
    
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
        setupBannerView()
        setupAdView()
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
            profileBgImageView,
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
            make.height.equalTo(205)
        }
        
        profileBgImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(132)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(72)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(profileBgImageView).offset(13)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(14)
            make.centerX.equalTo(profileImageView)
        }
    }
    
    private func setupBannerView() {
        contentView.addSubviews([
            shareBannerView,
            storyBannerView
        ])
        
        shareBannerView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(138)
        }
        
        storyBannerView.snp.makeConstraints { make in
            make.top.equalTo(shareBannerView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(shareBannerView)
            make.height.equalTo(90)
        }
    }
    
    private func setupAdView() {
        contentView.addSubview(adView)
        adView.addSubview(adEmptyView)
        
        adView.snp.makeConstraints { make in
            make.top.equalTo(storyBannerView.snp.bottom).offset(22)
            make.leading.trailing.bottom.equalToSuperview().inset(28)
            make.height.equalTo(100)
        }
        
        adEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        label.text = "@" + (UserDefaults.standard.getNickname() ?? "")
        label.font = .h2
        
        return label
    }
    
    private func createSettingButton() -> UIButton {
        let button = UIButton()
        
        button.setImage(ImageLiterals.settingIcon, for: .normal)
        button.tintColor = .pophoryBlack
        button.addTarget(self, action: #selector(onClickSetting), for: .touchUpInside)
        
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
    
    private func createProfileBgImageView() -> UIImageView {
        let imageView = UIImageView()

        imageView.backgroundColor = .pophoryLightPurple
        
        return imageView
    }
    
    private func createProfileImageView() -> UIImageView {
        let imageView = UIImageView(image: ImageLiterals.defaultProfile)
        
        imageView.makeRounded(radius: 36)
        imageView.isSkeletonable = true
        imageView.showAnimatedGradientSkeleton()
        
        return imageView
    }
    
    private func createProfileStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        return stackView
    }
    
    private func createProfileNameLabel() -> UILabel {
        let label = UILabel()
        
        label.text = UserDefaults.standard.getFullName()
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
    
    private func createShareBannerView() -> UIView {
        let view = MyPageBannerView(frame: .zero, title: "네컷사진 공유하기", description: "포릿이 너의 네컷사진을 전달해줄게!", image: ImageLiterals.myPageShareBanner)
        
        view.viewButton.addTarget(self, action: #selector(onClickShare), for: .touchUpInside)
        
        return view
    }
    
    private func createStoryBannerView() -> UIView {
        let view = MyPageBannerView(frame: .zero, title: "포릿 이야기 들으러 가기", description: "포릿이가 들려주는 '포포리' 이야기, 들어볼래?")
        
        view.viewButton.addTarget(self, action: #selector(onClickStory), for: .touchUpInside)
        
        return view
    }
    
    private func createBannerAdView() -> UIView {
        let view = UIView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickAd))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }
    
    // MARK: - Logics
    
    @objc private func onClickSetting() {
        delegate?.handleOnclickSetting()
    }
    
    @objc private func onClickShare() {
        delegate?.handleOnClickShare()
    }
    
    @objc private func onClickStory() {
        delegate?.handleOnClickStory()
    }
    
    @objc private func onClickAd() {
        delegate?.handleOnAd()
    }
    
    func updateNickname(_ nickname: String?) {
        nicknameLabel.text = nickname
    }
    
    func updateFullName(_ name: String?) {
        profileNameLabel.text = name
    }
    
    func updatePhotoCount(_ count: Int) {
        photoCountLabel.attributedText = NSMutableAttributedString()
            .regular("그동안 찍은 사진 ", color: .pophoryBlack)
            .regular("\(count)", color: .pophoryPurple)
            .regular("장", color: .pophoryBlack)
        photoCountLabel.hideSkeleton()
    }
    
    func updateProfileImage(_ imageUrl: String?) {
        if let url = imageUrl {
            profileImageView.kf.setImage(with: URL(string: url))
        }
        
        profileImageView.hideSkeleton()
    }
}
