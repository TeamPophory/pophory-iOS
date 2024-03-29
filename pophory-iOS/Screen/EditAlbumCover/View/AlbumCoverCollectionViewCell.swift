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
    
    private let albumCoverImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        albumCoverImageView.image = nil
    }
    
    
    private func setupUI() {
        contentView.shapeWithCustomCorners(topLeftRadius: 4, topRightRadius: 26, bottomLeftRadius: 4, bottomRightRadius: 26)
        contentView.clipsToBounds = true
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
