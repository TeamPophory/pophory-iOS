//
//  AddPhotoView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/02.
//

import UIKit

import SnapKit

final class AddPhotoView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let photoView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
    
    private lazy var photoAddButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primary)
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
        label.font = .h3
        label.textAlignment = .left
        return label
    }()
    
    private let albumView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    
    let dateStackView: PhotoInfoStackView = {
        let stackView = PhotoInfoStackView()
        stackView.setupTitle(title: "찍은 날짜")
        stackView.setupSelected(selected: true)
        stackView.setupIcon(icon: ImageLiterals.calanderIcon)
        stackView.setupExplain(explain: "2020.06.06(금)")
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
    
    let friendsStackView: PhotoInfoStackView = {
        let stackView = PhotoInfoStackView()
        stackView.setupTitle(title: "함께 찍은 친구")
        stackView.setupSelected(selected: false)
        stackView.setupIcon(icon: ImageLiterals.searchIcon)
        stackView.setupExplain(explain: "열심히 준비중이야!")
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

extension AddPhotoView {
    
    // MARK: - Layout
    
    private func setupStyle() {
        
    }
    
    private func setupLayout() {
        self.addSubviews([scrollView, photoAddButtonView])
        scrollView.addSubview(contentsView)
        photoAddButtonView.addSubview(photoAddButton)
        contentsView.addSubviews([photoView, photoInfoStackView])
        photoInfoStackView.addArrangedSubviews([albumStackView, dateStackView, studioStackView, friendsStackView])
        albumStackView.addArrangedSubviews([albumTitle, albumView])
        
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
        
        photoAddButton.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(60)
            $0.center.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        photoView.snp.makeConstraints {
            $0.height.equalTo(325)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        photoInfoStackView.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(22)
        }
        
        albumView.snp.makeConstraints {
            $0.height.equalTo(95)
            $0.width.equalTo(70)
        }
    }
    
    // MARK: - @objc
    
    // MARK: - Private Methods
}

