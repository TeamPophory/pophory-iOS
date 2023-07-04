//
//  AlbumDetailView.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

final class AlbumDetailView: BaseView {
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.backButtonIcon, for: .normal)
        return button
    }()
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.myAlbumPlusButtonIcon, for: .normal)
        return button
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray300
        return view
    }()
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.text = "최근에 찍은 순"
        label.textColor = .pophoryGray500
        label.font = .c1
        return label
    }()
    let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.arrowUpDown, for: .normal)
        return button
    }()

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
            [ backButton,
              plusButton,
              lineView,
              sortLabel,
              sortButton ]
        )
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(24)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom).offset(21)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        sortLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(45)
        }
        
        sortButton.snp.makeConstraints {
            $0.centerY.equalTo(sortLabel)
            $0.trailing.equalToSuperview().inset(17)
            $0.size.equalTo(24)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .pophoryWhite
    }
}
