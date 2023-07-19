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
    func albumCoverEditButtonDidTapped()
}

final class HomeAlbumView: UIView, GettableHomeAlbumProperty {

    private var privateStatusLabelText: String
    private let maxPhotoCount: Int = 15
    var imageDidTappedDelegate: ImageViewDidTappedProtocol?
    var homeAlbumViewButtonTappedDelegate: HomeAlbumViewButtonTappedProtocol?
    
    var statusLabelText: String {
        get {
            return privateStatusLabelText
        }
        set {
            privateStatusLabelText = newValue + "/\(maxPhotoCount)"
            
            let attributedText = NSMutableAttributedString(string: privateStatusLabelText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.pophoryPurple, range: NSRange(location: 0, length: newValue.count))
            self.statusLabel.attributedText = attributedText
        }
    }

    private let appLogo: UIImageView = UIImageView(image: ImageLiterals.logIcon)
    private let headTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString()
            .regular("포포리 앨범", font: .head1Bold, color: .pophoryPurple)
            .regular("에\n소중한 추억을 보관해 봐!", font: .head1Medium)
        label.attributedText = attributedText
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
    private lazy var albumCoverEditButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.changeElbumCover, for: .normal)
        button.addTarget(self, action: #selector(albumCoverEditButtonDidTapped), for: .touchUpInside)
        return button
    }()
    private let progressView: UIView = UIView()
    private let progressBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        view.layer.cornerRadius = 3
        return view
    }()
    private let progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryPurple
        view.layer.cornerRadius = 3
        return view
    }()
    private let progressBarIcon = UIImageView(image: ImageLiterals.progressBarIcon)
    
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
            [
                appLogo,
                headTitle,
                albumImageView,
                albumCoverEditButton,
                progressView
            ]
        )
        
        progressView.addSubviews(
            [
                progressBackgroundView,
                progressBarView,
                progressBarIcon,
                statusLabel
            ]
        )
        
        appLogo.snp.makeConstraints {
            $0.top.equalTo(headerHeightByNotch(27))
            $0.leading.equalToSuperview().offset(20)
        }
        
        headTitle.snp.makeConstraints {
            $0.top.equalTo(appLogo.snp.bottom).offset(constraintByNotch(20, 15))
            $0.leading.equalToSuperview().offset(20)
        }
        
        albumImageView.snp.makeConstraints {
            $0.top.equalTo(headTitle.snp.bottom).offset(constraintByNotch(30, 25))
            $0.leading.equalToSuperview().offset(45)
            $0.aspectRatio(CGSize(width: 280, height: 380))
            $0.centerX.equalToSuperview()
        }
        
        albumCoverEditButton.snp.makeConstraints {
            $0.bottom.equalTo(headTitle.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(44)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(24)
            $0.height.equalTo(38)
            $0.horizontalEdges.equalTo(albumImageView)
        }
        
        progressBackgroundView.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(70)
        }
        
        progressBarView.snp.makeConstraints {
            $0.leading.equalTo(progressBackgroundView)
            $0.height.equalTo(6)
            $0.width.equalTo(0)
            $0.centerY.equalToSuperview()
        }
        progressBarView.bringSubviewToFront(self)
        
        progressBarIcon.snp.makeConstraints {
            $0.centerY.equalTo(progressBarView)
            $0.trailing.equalTo(progressBarView.snp.trailing).offset(6)
            $0.size.equalTo(38)
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
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
    private func albumCoverEditButtonDidTapped() {
        homeAlbumViewButtonTappedDelegate?.albumCoverEditButtonDidTapped()
    }
    
    func updateProgressBarWidth(
        updateWidth: Int
    ) {
        progressBarView.snp.updateConstraints {
            $0.width.equalTo(updateWidth)
        }
    }
    
    func updateProgressBarIcon(
        isAlbumFull: Bool
    ) {
        if isAlbumFull {
            progressBarIcon.image = ImageLiterals.progressBarIconFull
        } else {
            progressBarIcon.image = ImageLiterals.progressBarIcon
        }
    }
}
