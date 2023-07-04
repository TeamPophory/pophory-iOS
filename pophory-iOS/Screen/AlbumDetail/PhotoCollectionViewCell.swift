//
//  PhotoCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/04.
//

import UIKit

import SnapKit
//import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "ScrapStorageCollectionViewCell"
    
    let photoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(photoImage)
    }
}
