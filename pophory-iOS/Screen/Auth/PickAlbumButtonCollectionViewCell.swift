//
//  PickAlbumButtonCollectionViewCell.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/04.
//

import UIKit

import SnapKit

final class PickAlbumButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PickAlbumButtonCollectionViewCell"
    
    private let selectView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        view.makeRounded(radius: 25)
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

extension PickAlbumButtonCollectionViewCell {
    private func setupLayout() {
        
        contentView.addSubview(selectView)
        
        selectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

