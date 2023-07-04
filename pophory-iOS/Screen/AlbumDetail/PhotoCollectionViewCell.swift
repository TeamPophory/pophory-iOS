//
//  PhotoCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/04.
//

import UIKit

import SnapKit
import Kingfisher

protocol SettablePhotoProperty {
    var photoImageString: String { get set }
}

final class PhotoCollectionViewCell: UICollectionViewCell, SettablePhotoProperty {
    
    static var identifier: String = "ScrapStorageCollectionViewCell"
    
    private let privatePhotoImage = UIImageView()
    private var privatePhotoImageString: URL?
    var photoImageString: String {
        get {
            guard let privatePhotoImageString = privatePhotoImageString?.absoluteString else { return String() }
            return privatePhotoImageString
        }
        set {
            if let photoUrl = URL(string: newValue) {
                self.privatePhotoImageString = photoUrl
                self.configCell(imageUrl: photoUrl)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(privatePhotoImage)
        
        privatePhotoImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configCell(imageUrl: URL) {
        privatePhotoImage.kf.setImage(with: imageUrl)
    }
}
