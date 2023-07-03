//
//  PhotoInfoStackView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/03.
//

import UIKit

class PhotoInfoStackView: UIStackView {
    
    // MARK: - Properties
    
    // MARK: - UI Properties
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .pophoryBlack
        label.textAlignment = .left
        return label
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryBlack
        view.makeRounded(radius: 18)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.pophoryGray300.cgColor
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .t1
        label.textColor = .pophoryBlack
        label.textAlignment = .left
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Life Cycle
    
    
}

extension PhotoInfoStackView {
    
    // MARK: - Layout
    
    private func setupStyle() {
        self.axis = .vertical
        self.spacing = 16
    }

    private func setupLayout() {
        self.addArrangedSubviews([mainLabel,
                                  infoView])
        
        mainLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        infoView.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoView.addSubviews([infoLabel,
                              infoButton])
        
        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17)
        }
    }
    
    // MARK: - @objc
    
    // MARK: - Private Methods
}
