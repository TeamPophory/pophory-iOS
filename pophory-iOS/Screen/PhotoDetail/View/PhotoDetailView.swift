//
//  PhotoDetailView.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

import SnapKit
import Kingfisher

final class PhotoDetailView: UIView {
    
    // MARK: - Properties
    
    private var takenAt: String
    private var studio: String
    private var imageUrl: String
    private var photoType: PhotoCellType
    
    // MARK: - UI Properties
    
    private let separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    
    private let photoDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryWhite
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    
    private let photoImageView = UIImageView()
    
    private let photoInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var takenAtLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.textColor = .pophoryBlack
        label.text = takenAt
        return label
    }()
    
    private lazy var studioLabel: UILabel = {
        let label = UILabel()
        label.font = .text1
        label.textColor = .pophoryBlack
        label.text = studio
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.borderColor = UIColor.pophoryBlack.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 37 / 2
        return label
    }()
    
    // MARK: - Life Cycle
    
    init(frame: CGRect, imageUrl: String, takenAt: String, studio: String, type: PhotoCellType) {
        self.imageUrl = imageUrl
        self.takenAt = takenAt
        self.studio = studio
        self.photoType = type
        super.init(frame: frame)
        
        configureUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoDetailView {
    private func configureUI() {
        backgroundColor = .pophoryWhite
        photoImageView.kf.setImage(with: URL(string: imageUrl))
        
        if studio == "NONE" {
            studioLabel.isHidden = true
        }
    }
    
    private func setupLayout() {
        photoInfoStackView.addArrangedSubviews([takenAtLabel, studioLabel])
        photoDetailView.addSubview(photoImageView)
        addSubviews([separateLine, photoDetailView, bottomLine, photoInfoStackView])
        
        separateLine.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(125)
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        photoDetailView.snp.makeConstraints { make in
            make.top.equalTo(separateLine.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(554)
        }
        
        switch photoType {
        case .horizontal:
            photoImageView.snp.makeConstraints { make in
                make.directionalHorizontalEdges.centerY.equalToSuperview()
                make.height.equalTo(213)
            }
        case .vertical:
            photoImageView.snp.makeConstraints { make in
                make.directionalHorizontalEdges.centerY.equalToSuperview()
                make.directionalVerticalEdges.equalToSuperview().inset(20)
            }
        case .none:
            return
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(photoDetailView.snp.bottom)
            make.directionalHorizontalEdges.equalTo(photoDetailView)
            make.height.equalTo(1)
        }
        
        studioLabel.snp.makeConstraints { make in
            make.width.equalTo(104)
            make.height.equalTo(37)
        }
        
        photoInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(photoDetailView.snp.bottom).offset(14)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
    }
}
