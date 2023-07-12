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
    
    enum CellType {
        case albumDetail, myPage
    }
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.defaultPhotoIcon
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = ImageLiterals.defaultPhotoIcon
    }
    
    private func setupLayout() {
        self.addSubview(photoImage)
        
        photoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configCell(
        imageUrl: String,
        cellType: CellType = .albumDetail
    ) {
        if imageUrl == "" {
            photoImage.image = ImageLiterals.defaultPhotoIcon
        } else {
            let url = URL(string: imageUrl)
            photoImage.kf.setImage(with: url)
            photoImage.contentMode = cellType == .albumDetail ? .scaleToFill : .scaleAspectFill
        }
    }
}
