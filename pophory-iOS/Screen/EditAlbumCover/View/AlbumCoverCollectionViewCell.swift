//
//  AlbumCoverCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

import SnapKit

final class AlbumCoverCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AlbumCoverCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        let rightRadius = 26.0
        let rightCornerMask: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        imageView.makeRounded(radius: rightRadius, maskedCorners: rightCornerMask)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(albumCoverImageView)
        
        albumCoverImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configCell(
        albumCoverImage: UIImage
    ) {
        albumCoverImageView.image = albumCoverImage
    }
}
