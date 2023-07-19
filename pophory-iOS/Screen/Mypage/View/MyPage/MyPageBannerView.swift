//
//  MyPageBannerView.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/15.
//

import UIKit

class MyPageBannerView: UIView {
    
    private lazy var titleLabel: UILabel = { createTitleLabel() }()
    private lazy var chevronImageView: UIImageView = { UIImageView(image: ImageLiterals.chevronRightIcon) }()
    private lazy var bannerImageView: UIImageView = { UIImageView() }()
    private lazy var descriptionLabel: UILabel = { createDescriptionLabel() }()
    lazy var viewButton: UIButton = { UIButton() }()
    
    init(frame: CGRect, title: String, description: String, image: UIImage? = nil) {
        super.init(frame: frame)
                
        titleLabel.text = title
        descriptionLabel.text = description
        bannerImageView.image = image
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageBannerView {
    
    private func setupView() {
        backgroundColor = UIColor(hex: "#F5F5F5")
        makeRounded(radius: 16)
        
        addSubviews([
            titleLabel,
            chevronImageView,
            bannerImageView,
            descriptionLabel,
            viewButton
        ])
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.centerY.equalTo(titleLabel)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(12)
            make.trailing.equalTo(bannerImageView.snp.leading).inset(20)
        }
        
        viewButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .popupTitle
        
        return label
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .caption1
        label.textColor = .pophoryGray500
        label.numberOfLines = 0
        
        return label
    }
}
