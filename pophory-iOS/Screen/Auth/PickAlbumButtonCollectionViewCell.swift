//
//  PickAlbumButtonCollectionViewCell.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/04.
//

import UIKit

import SnapKit

final class PickAlbumButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PickAlbumButtonCollectionViewCell"
    
    var isSelectedCell: Bool = false {
        didSet {
            checkImageView.isHidden = !isSelectedCell
        }
    }
    
    private let selectView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .pophoryGray300
        view.makeRounded(radius: 25)
        return view
    }()
    
    let checkImageView = UIImageView(image: ImageLiterals.checkBigIconWhite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupCheckImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickAlbumButtonCollectionViewCell {
    private func setupLayout() {
        
        contentView.addSubview(selectView)
        
        selectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCheckImageView() {
        checkImageView.isHidden = true
        addSubview(checkImageView)
        
        checkImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureCell(forImage: UIImage) {
        selectView.image = forImage
    }
}

