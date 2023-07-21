//
//  ShareView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class ShareView: UIView {
    
    // MARK: - UI Properties
    
    private let contentView = UIView()
    
    private let sharePhotoView: UIView = {
        let view = UIView()
        view.makeRounded(radius: 20)
        view.layer.borderColor = UIColor.pophoryGray400.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowOffset = .init(width: 8, height: 8)
        return view
    }()
    
    let shareButton: PophoryButton = {
    let buttonBuilder = PophoryButtonBuilder()
    .setStyle(.primaryBlack)
    .setTitle(.share)
    return buttonBuilder.build()
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.defaultProfile
        return imageView
    }()
    
    private let userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .head3
        return label
    }()
    
    let userIDLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .caption2
        label.textColor = .pophoryGray400
        return label
    }()
    
    let shareImageView = UIImageView()
    
    private let logoImageView = UIImageView(image: ImageLiterals.shareIcon)

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareView {
    
    private func setupStyle() {
        self.backgroundColor = .pophoryWhite
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubviews([shareButton, contentView])
                        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(shareButton.snp.top).offset(-10)
        }
        
        shareButton.addCenterXConstraint(to: self)
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        contentView.addSubview(sharePhotoView)
        
        sharePhotoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        sharePhotoView.addSubviews([profileStackView ,shareImageView, logoImageView])

        profileStackView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(20)
        }
                
        shareImageView.snp.makeConstraints {
            $0.height.equalTo(440)
            $0.top.equalTo(profileStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(logoImageView.snp.top).offset(-16)
        }
        
        logoImageView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(112)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        profileStackView.addArrangedSubviews([profileImageView, userInfoStackView])
        
        profileImageView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(50)
            $0.top.bottom.equalToSuperview()
        }
        userInfoStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        userInfoStackView.addArrangedSubviews([userNameLabel, userIDLabel])
        userNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        userIDLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}
