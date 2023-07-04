//
//  ChangeSortView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

final class ChangeSortView: BaseView {
    
    private let headTitle: UILabel = {
        let label = UILabel()
        label.text = "정렬 선택하기"
        label.font = .h2
        label.textColor = .pophoryBlack
        return label
    }()
    private let currentSortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    private let currentSortLabelText: UILabel = {
        let label = UILabel()
        label.text = "최근에 찍은 순"
        label.font = .t2
        label.textColor = .pophoryBlack
        return label
    }()
    private let oldSortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    private let oldSortLabelText: UILabel = {
        let label = UILabel()
        label.text = "옛날에 찍은 순"
        label.font = .t2
        label.textColor = .pophoryBlack
        return label
    }()
    private let currentSortCheckImageView = UIImageView(image: ImageLiterals.checkBigIcon)
    private let oldSortCheckImageView = UIImageView(image: ImageLiterals.checkBigIcon)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubviews(
            [ headTitle,
              currentSortButton,
              currentSortLabelText,
              oldSortButton,
              oldSortLabelText,
              currentSortCheckImageView,
              oldSortCheckImageView ]
        )
        
        headTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        currentSortButton.snp.makeConstraints {
            $0.top.equalTo(headTitle.snp.bottom).offset(20)
            $0.height.equalTo(46)
            $0.leading.trailing.equalToSuperview()
        }
        self.bringSubviewToFront(currentSortButton)
        
        currentSortLabelText.snp.makeConstraints {
            $0.top.equalTo(headTitle.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        currentSortCheckImageView.snp.makeConstraints {
            $0.centerY.equalTo(currentSortButton)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        oldSortButton.snp.makeConstraints {
            $0.top.equalTo(currentSortButton.snp.bottom)
            $0.height.equalTo(46)
            $0.leading.trailing.equalToSuperview()
        }
        self.bringSubviewToFront(oldSortButton)
        
        oldSortLabelText.snp.makeConstraints {
            $0.top.equalTo(currentSortButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        oldSortCheckImageView.snp.makeConstraints {
            $0.centerY.equalTo(oldSortButton)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
}
