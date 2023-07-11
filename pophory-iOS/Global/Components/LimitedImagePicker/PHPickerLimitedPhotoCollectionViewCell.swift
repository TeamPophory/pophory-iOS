//
//  PHPickerLimitedPhotoCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/12.
//

import UIKit

import SnapKit

class PHPickerLimitedPhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "LimitedPhotoCollectionViewCell"
    
    // MARK: - UI Properties
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
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

extension PHPickerLimitedPhotoCollectionViewCell {
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Method
    
    func configureCell(image: UIImage) {
        imageView.image = image
    }
}
