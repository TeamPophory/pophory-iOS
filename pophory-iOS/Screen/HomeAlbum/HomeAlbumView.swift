//
//  HomeAlbumView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

//MARK: - Protocols

protocol GettableHomeAlbumProperty {
    var statusLabelText: String { get set }
}

protocol ImageViewDidTappedProtocol {
    func imageDidTapped()
}

protocol HomeAlbumViewButtonTappedProtocol {
    func albumCoverEditButtonDidTapped()
}

// MARK: - HomeAlbumView

final class HomeAlbumView: UIView, GettableHomeAlbumProperty {
    
    // MARK: - Properties
    
    private var privateStatusLabelText: String
    private var maxPhotoLimit: Int
    var imageDidTappedDelegate: ImageViewDidTappedProtocol?
    var homeAlbumViewButtonTappedDelegate: HomeAlbumViewButtonTappedProtocol?
    
    var statusLabelText: String {
        get {
            return privateStatusLabelText
        }
        set {
            privateStatusLabelText = newValue + "/\(maxPhotoLimit)"
            
            let attributedText = NSMutableAttributedString(string: privateStatusLabelText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.pophoryPurple, range: NSRange(location: 0, length: newValue.count))
            self.statusLabel.attributedText = attributedText
        }
    }
    
    // MARK: - UI Properties
    
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.backgroundColor = .pophoryGray300
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
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
    
    // MARK: - Life Cycle
    
    init(statusLabelText: String) {
        privateStatusLabelText = statusLabelText
        maxPhotoLimit = 0
        super.init(frame: .zero)
        
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        albumImageView.shapeWithCustomCorners(topLeftRadius: 4, topRightRadius: 26, bottomLeftRadius: 4, bottomRightRadius: 26)
        albumImageView.clipsToBounds = true
    }
}

//MARK: - Extensions

extension HomeAlbumView {
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
        
        appLogo.snp.makeConstraints { make in
            make.top.equalTo(headerHeightByNotch(27))
            make.leading.equalToSuperview().offset(20)
        }
        
        headTitle.snp.makeConstraints { make in
            make.top.equalTo(appLogo.snp.bottom).offset(constraintByNotch(20, 15))
            make.leading.equalToSuperview().offset(20)
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(headTitle.snp.bottom).offset(constraintByNotch(30, 25))
            make.leading.equalToSuperview().offset(45)
            make.aspectRatio(CGSize(width: 280, height: 380))
            make.centerX.equalToSuperview()
        }
        
        albumCoverEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(headTitle.snp.bottom)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(24)
            make.height.equalTo(38)
            make.horizontalEdges.equalTo(albumImageView)
        }
        
        progressBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(70)
        }
        
        progressBarView.snp.makeConstraints { make in
            make.leading.equalTo(progressBackgroundView)
            make.height.equalTo(6)
            make.width.equalTo(0)
            make.centerY.equalToSuperview()
        }
        progressBarView.bringSubviewToFront(self)
        
        progressBarIcon.snp.makeConstraints { make in
            make.centerY.equalTo(progressBarView)
            make.leading.equalTo(progressBarView.snp.trailing).inset(5)
            make.size.equalTo(38)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc
    private func imageTapped() {
        imageDidTappedDelegate?.imageDidTapped()
    }
    
    @objc
    private func albumCoverEditButtonDidTapped() {
        homeAlbumViewButtonTappedDelegate?.albumCoverEditButtonDidTapped()
    }
    
    // MARK: - Methods
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
    
    func updateProgressBarWidth(updateWidth: Int) {
        progressBarView.snp.updateConstraints { make in
            make.width.equalTo(updateWidth)
        }
    }
    
    func updateProgressBarIcon(isAlbumFull: Bool) {
        if isAlbumFull {
            progressBarIcon.image = ImageLiterals.progressBarIconFull
        } else {
            progressBarIcon.image = ImageLiterals.progressBarIcon
        }
    }
    
    func setMaxPhotoCount(_ maxPhotoCount: Int) {
        self.maxPhotoLimit = maxPhotoCount
    }
}
