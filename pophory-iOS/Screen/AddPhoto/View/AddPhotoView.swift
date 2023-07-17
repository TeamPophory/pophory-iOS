//
//  AddPhotoView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/02.
//

import UIKit

import SnapKit

final class AddPhotoView: UIView {
    
    // MARK: - UI Properties
    
    var photoType: PhotoCellType = .vertical {
        didSet {
            switch photoType {
            case .vertical, .none:
                photoView.image = ImageLiterals.addPhotoBackgroundVertical
                setupVerticle()
            case .horizontal:
                photoView.image = ImageLiterals.addPhotoBackgroundHorizontal
                setupHorizontal()
            }
        }
    }
        
    // MARK: - UI Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let scrollContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.addPhotoBackgroundVertical
        return view
    }()
    
    let photo = UIImageView()
    
    private let photoInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        return stackView
    }()
    private let photoAddButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryWhite
        return view
    }()
    
    let photoAddButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.addPhoto)
        return buttonBuilder.build()
    }()
    
    private let albumStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        return stackView
    }()
    
    private let albumTitle: UILabel = {
        let label = UILabel()
        label.text = "내 앨범"
        label.font = .head3
        label.textAlignment = .left
        return label
    }()
    let albumCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 70, height: 95)
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(PhotoAlbumCollectionViewCell.self, forCellWithReuseIdentifier: PhotoAlbumCollectionViewCell.identifier)
        return view
    }()
    
    let dateStackView: PhotoInfoStackView = {
        let stackView = PhotoInfoStackView()
        stackView.setupTitle(title: "찍은 날짜")
        stackView.setupSelected(selected: true)
        stackView.setupIcon(icon: ImageLiterals.calanderIcon)
        stackView.setupExplain(explain: DateManager.dateToString(date: Date()))
        return stackView
    }()
    let studioStackView: PhotoInfoStackView = {
        let stackView = PhotoInfoStackView()
        stackView.setupTitle(title: "사진관")
        stackView.setupSelected(selected: false)
        stackView.setupIcon(icon: ImageLiterals.downIcon)
        stackView.setupExplain(explain: "사진관을 선택해줘")
        return stackView
    }()
//    let friendsStackView: PhotoInfoStackView = {
//        let stackView = PhotoInfoStackView()
//        stackView.setupTitle(title: "함께 찍은 친구")
//        stackView.setupSelected(selected: false)
//        stackView.setupIcon(icon: ImageLiterals.searchIcon)
//        stackView.setupExplain(explain: "열심히 준비중이야!")
//        return stackView
//    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddPhotoView {
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubviews([scrollView, photoAddButtonView])
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(photoAddButtonView.snp.top)
        }
        photoAddButtonView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(scrollContentsView)
        
        scrollContentsView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        photoInfoStackView.addArrangedSubviews([albumStackView, dateStackView, studioStackView])
        
        scrollContentsView.addSubviews([photoView, photoInfoStackView])
        photoView.addSubview(photo)
        
        photoView.snp.makeConstraints {
            $0.height.equalTo(325)
            $0.top.leading.trailing.equalToSuperview()
        }
        photoInfoStackView.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(22)
        }
        
        photo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(94)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        
        albumStackView.addArrangedSubviews([albumTitle, albumCollectionView])
        
        albumCollectionView.snp.makeConstraints {
            $0.height.equalTo(95)
            $0.leading.trailing.equalToSuperview()
        }
                
        photoAddButton.addCenterConstraint(to: photoAddButtonView)
    }
    
    // MARK: - func
    
    func setupVerticle() {
        photo.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(94)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupHorizontal() {
        photo.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.top.bottom.equalToSuperview().inset(69)
        }
    }
}

