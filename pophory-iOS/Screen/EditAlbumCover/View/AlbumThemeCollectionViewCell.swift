//
//  AlbumThemeCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2/8/24.
//

import UIKit

import SnapKit

final class AlbumThemeCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "AlbumThemeCollectionViewCell"
    
    private let albumThemeImageView = UIImageView()
    private var index: IndexPath?
    private var isClicked = false {
        didSet {
            updateUI()
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
        albumThemeImageView.image = nil
    }
}

extension AlbumThemeCollectionViewCell {
    private func setupLayout() {
        contentView.addSubview(albumThemeImageView)
        
        albumThemeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI() {
        if let index {
            if isClicked {
                albumThemeImageView.image = AlbumData.albumThemeAlphaImages[index.row]
            } else {
                albumThemeImageView.image = AlbumData.albumThemeImages[index.row]
            }
        }
    }
    
    func configCell(
        _ index: IndexPath
    ) {
        if isClicked {
            albumThemeImageView.image = AlbumData.albumThemeAlphaImages[index.row]
        } else {
            albumThemeImageView.image = AlbumData.albumThemeImages[index.row]
        }
        self.index = index
    }
    
    func setClickedState(_ state: Bool) {
        isClicked = state
    }
    
    func getClickedState() -> Bool { 
        return self.isClicked
    }
}

