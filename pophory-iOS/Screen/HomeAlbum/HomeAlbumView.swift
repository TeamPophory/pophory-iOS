//
//  HomeAlbumView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

protocol GettableHomeAlbumProperty {
    var statusLabelText: String { get set }
}

protocol ImageViewDidTappedProtocol {
    func imageDidTapped()
}

final class HomeAlbumView: UIView, GettableHomeAlbumProperty {

    private var privateStatusLabelText: String
    var imageDidTappedDelegate: ImageViewDidTappedProtocol?
    
    var statusLabelText: String {
        get {
            return privateStatusLabelText
        }
        set {
            privateStatusLabelText = newValue
            self.statusLabel.text = privateStatusLabelText + "/30"
        }
    }

    private let appLogo: UIImageView = UIImageView(image: ImageLiterals.logIcon)
    private let headTitle: UILabel = {
        let label = UILabel()
        label.font = .h1
        label.text = "포릿만의 네컷 앨범에\n소중한 추억을 보관해봐!"
        label.asColor(targetString: "포릿만의 네컷 앨범", color: .pophoryPurple)
        label.numberOfLines = 2
        return label
    }()
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .pophoryGray300
        let rightRadius = 26.0
        let rightCornerMask: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.makeRounded(radius: rightRadius, maskedCorners: rightCornerMask)
        return imageView
    }()
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryPurple
        view.layer.cornerRadius = 20
        return view
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .t1
        label.textColor = .white
        return label
    }()
    
    init(
        statusLabelText: String
    ) {
        privateStatusLabelText = statusLabelText
        super.init(frame: .zero)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubviews(
            [ appLogo,
            headTitle,
            albumImageView,
            statusView ]
        )
        
        statusView.addSubview(statusLabel)
        
        appLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(66)
            $0.leading.equalToSuperview().offset(20)
        }
        
        headTitle.snp.makeConstraints {
            $0.top.equalTo(appLogo.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        albumImageView.snp.makeConstraints {
            $0.top.equalTo(headTitle.snp.bottom).offset(30)
            $0.height.equalTo(380)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        
        statusView.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(38)
            $0.width.equalTo(64)
        }
        
        statusLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
    
    @objc
    private func imageTapped() {
        imageDidTappedDelegate?.imageDidTapped()
    }
}
