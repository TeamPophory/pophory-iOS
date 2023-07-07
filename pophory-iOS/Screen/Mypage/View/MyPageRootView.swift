//
//  MyPageRootView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/06.
//

import UIKit

import SnapKit

class MyPageRootView: UIView {
    
    // MARK: - UI Properties
    
    private lazy var headerStackView: UIStackView = { createHeaderStackView() }()
    private lazy var nicknameLabel: UILabel = { createNicknameLabel() }()
    private lazy var settingButton: UIButton = { createSettingButton() }()
    private lazy var headerBorderView: UIView = { createHeaderBorderView() }()
    
    private lazy var profileView: UIView = { UIView() }()
    private lazy var profileImageView: UIImageView = { createProfileImageView() }()
    private lazy var profileStackView: UIStackView = { createProfileStackView() }()
    private lazy var profileNameLabel: UILabel = { createProfileNameLabel() }()
    private lazy var photoCountLabel: UILabel = { createPhotoCountLabel() }()
    
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
        setupProfileView()
        // TODO: - 광고 뷰 추가
        
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
            make.top.leading.trailing.equalToSuperview()
        }
        
        headerBorderView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupProfileView() {
        addSubview(profileView)
        
        profileView.addSubviews([
            profileImageView,
            profileStackView
        ])
        
        profileStackView.addArrangedSubviews([
            profileNameLabel,
            photoCountLabel
        ])
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(72)
            make.top.equalToSuperview().offset(22)
            make.leading.bottom.equalToSuperview().inset(20)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.centerY.equalTo(profileImageView.snp.centerY)
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
}
