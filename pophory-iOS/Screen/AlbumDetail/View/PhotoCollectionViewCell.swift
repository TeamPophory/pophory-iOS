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
    
    var photoMetaData: PhotoUrlResponseDto?
    
    enum CellType {
        case albumDetail, myPage
    }
    private var cellType: CellType = .albumDetail
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.defaultPhotoIcon
        imageView.layer.cornerRadius = 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.layer.cornerRadius = 2
        view.clipsToBounds = true
        return view
    }()
    
    private let selectedIcon: UIImageView = UIImageView(image: ImageLiterals.checkBigIconWhite)
    
    override var isSelected: Bool {
        didSet {
            if cellType == .myPage {
                setSelected(isSelected)
            }
        }
    }
    
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
    
    func configCell(
        imageUrl: String,
        cellType: CellType = .albumDetail
    ) {
        self.cellType = cellType
        
        if imageUrl == "" {
            photoImage.image = ImageLiterals.defaultPhotoIcon
        } else {
            let url = URL(string: imageUrl)
            photoImage.kf.setImage(with: url)
            photoImage.contentMode = cellType == .albumDetail ? .scaleToFill : .scaleAspectFill
        }
    }
}

extension PhotoCollectionViewCell {
    private func setupLayout() {
        isSelected = false
        
        addSubviews([
            photoImage,
            selectedView
        ])
        
        selectedView.addSubview(selectedIcon)
        selectedView.isHidden = true
        
        photoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectedIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setSelected(_ isSelected: Bool) {
        selectedView.isHidden = !isSelected
    }
}
