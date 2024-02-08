//
//  AlbumThemeCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2/8/24.
//

import UIKit

import SnapKit

final class AlbumThemeCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AlbumThemeCollectionViewCell"
    
    private let albumThemeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumThemeCollectionViewCell {
    private func setupLayout() {
        contentView.addSubview(albumThemeImageView)
        
        albumThemeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configCell(
        _ img: UIImage
    ) {
        albumThemeImageView.image = img
    }
}

