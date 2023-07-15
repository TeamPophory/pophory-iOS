//
//  SignUpIndicatorCollectionViewCell.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/14.
//

import UIKit

import SnapKit

final class SignUpIndicatorCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PickAlbumButtonCollectionViewCell"
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        view.makeRounded(radius: 2)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpIndicatorCollectionViewCell {
    private func setupLayout() {
        
        contentView.addSubview(indicatorView)
        
        indicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
