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

protocol HomeAlbumViewButtonTappedProtocol {
    func elbumCoverEditButtonDidTapped()
}

final class HomeAlbumView: UIView, GettableHomeAlbumProperty {

    private var privateStatusLabelText: String
    var imageDidTappedDelegate: ImageViewDidTappedProtocol?
    var homeAlbumViewButtonTappedDelegate: HomeAlbumViewButtonTappedProtocol?
    
    var statusLabelText: String {
        get {
            return privateStatusLabelText
        }
        set {
            privateStatusLabelText = newValue + "/15"
            
            let attributedText = NSMutableAttributedString(string: privateStatusLabelText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.pophoryPurple, range: NSRange(location: 0, length: newValue.count))
            self.statusLabel.attributedText = attributedText
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
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .head2
        label.textColor = .pophoryGray500
        return label
    }()
    private lazy var elbumCoverEditButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.changeElbumCover, for: .normal)
        button.addTarget(self, action: #selector(elbumCoverEditButtonDidTapped), for: .touchUpInside)
        return button
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
              statusLabel,
              elbumCoverEditButton
            ]
        )
        
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

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(50)
        }
        
        elbumCoverEditButton.snp.makeConstraints {
            $0.bottom.equalTo(headTitle.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(44)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
    
    @objc
    private func imageTapped() {
        imageDidTappedDelegate?.imageDidTapped()
    }
    
    @objc
    private func elbumCoverEditButtonDidTapped() {
        homeAlbumViewButtonTappedDelegate?.elbumCoverEditButtonDidTapped()
    }
}
