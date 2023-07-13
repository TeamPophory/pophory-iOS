//
//  PhotoAlbumCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/04.
//

import UIKit

import SnapKit

final class PhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "AddPhotoAlbumCell"
    
    override var isSelected: Bool {
        didSet{
                selectedView.isHidden = !isSelected
        }
    }
    
    // MARK: - UI Properties
    
    private let photoAlbum: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .pophoryGray300
        let rightRadius = 6.0
        let rightCornerMask: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.makeRounded(radius: rightRadius, maskedCorners: rightCornerMask)
        return view
    }()
    
    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryBlack.withAlphaComponent(0.3)
        view.isHidden = true
        return view
    }()
    
    private let selectedIcon: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.checkBigIconWhite
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
        contentView.addSubviews([photoAlbum, selectedView])
        selectedView.addSubview(selectedIcon)

        photoAlbum.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        selectedIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Method
    
    func configureCell(image: UIImage) {
        photoAlbum.image = image
    }
}
