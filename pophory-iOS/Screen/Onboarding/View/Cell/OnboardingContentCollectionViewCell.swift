//
//  OnboardingContentCollectionViewCell.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

import SnapKit

final class OnboardingContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingContentCollectionViewCell"
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingContentCollectionViewCell {
    
    private func setupLayout() {
        contentView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureImage(image: UIImage) {
        contentImageView.image = image
    }
}
