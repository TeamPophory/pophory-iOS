//
//  PhotoCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/04.
//

import UIKit

import SnapKit
import Kingfisher

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "PhotoCollectionViewCell"
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
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
        self.addSubview(photoImage)
        
        photoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configCell(imageUrl: String) {
        let imageUrl = URL(string: imageUrl)
        photoImage.kf.setImage(with: imageUrl)
    }
}
