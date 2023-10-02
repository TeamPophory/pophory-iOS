//
//  ShareView.swift
//  ShareExtension
//
//  Created by 김다예 on 2023/10/02.
//

import UIKit

import SnapKit

@frozen
enum PhotoCellType {
    case vertical
    case horizontal
    case none
}

class ShareView: UIView {

//     MARK: - UI Properties
    
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
    
    // iphone 13 mini 기준 verticle 이미지 height
    private var imageConstraint: CGFloat = 285
        
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
    
    let photoAddButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("사진 추가하기", for: .normal)
        button.setTitleColor(.pophoryWhite, for: .normal)
        button.layer.cornerRadius = 30
        return button
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
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareView {
    
    // MARK: - Layout
    
    private func setupStyle() {
        self.backgroundColor = .pophoryWhite
    }
    
    private func setupLayout() {
        self.addSubview(scrollView)
        self.addSubview(photoAddButtonView)

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
        
        photoInfoStackView.addArrangedSubview(dateStackView)
        photoInfoStackView.addArrangedSubview(studioStackView)

        scrollContentsView.addSubview(photoView)
        scrollContentsView.addSubview(photoInfoStackView)

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
                
        photoAddButtonView.addSubview(photoAddButton)
        
        photoAddButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - func
    
    func setupVerticle() {
        photo.snp.remakeConstraints {
            var width: CGFloat = 188
            // 세로 제약조건을 superView에 20씩 걸어놓고 사진의 원본 비율에 따라 width를 구함
            if let imageWidth = photo.image?.size.width, let imageHeight = photo.image?.size.height {
                width = imageWidth * (imageConstraint / imageHeight)
            }
            $0.width.equalTo(width)
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }

    func setupHorizontal() {
        photo.snp.remakeConstraints {
            var height: CGFloat = 188
            // 가로 제약조건을 superView에 45씩 걸어놓고 사진의 원본 비율에 따라 height를 구함
            if let imageWidth = photo.image?.size.width, let imageHeight = photo.image?.size.height {
                height = imageHeight * (imageConstraint / imageWidth)
            }
            $0.height.equalTo(height)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(45)
        }
    }
}

