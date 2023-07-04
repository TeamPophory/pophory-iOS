//
//  PhotoAlbumCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/04.
//

import UIKit

final class PhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let identifier = "AddPhotoAlbumCell"
    
    // MARK: - UI Properties
    
    private let photoAlbum: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .pophoryGray300
        return view
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoAlbumCollectionViewCell {
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(photoAlbum)
        
        photoAlbum.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Method
    
    func configureCell(image: UIImage) {
        photoAlbum.image = image
    }
}
