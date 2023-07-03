//
//  PhotoInfoStackView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/03.
//

import UIKit

class PhotoInfoStackView: UIStackView {
    
    // MARK: - Properties
    
    /// 선택 완료 시 선택된 label의 색 변경
    private var didSelected: Bool = false {
        didSet {
            changeInfoLabelColor(selected: didSelected)
        }
    }
    
    // MARK: - UI Properties
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .pophoryBlack
        label.textAlignment = .left
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pophoryGray100
        button.makeRounded(radius: 18)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.pophoryGray300.cgColor
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .t1
        label.textColor = .pophoryBlack
        label.textAlignment = .left
        return label
    }()
    
    private lazy var infoIcon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoInfoStackView {
    
    // MARK: - Layout
    
    private func setupStyle() {
        self.axis = .vertical
        self.spacing = 16
    }
    
    private func setupLayout() {
        self.addArrangedSubviews(
            [mainLabel,
             infoButton]
        )
        
        mainLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoButton.addSubviews(
            [infoLabel,
             infoIcon]
        )
        
        infoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        infoIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17)
        }
    }
    
    // MARK: - @objc
    
    // MARK: - Private Methods
    
    private func changeInfoLabelColor(selected: Bool) {
        if selected {
            infoLabel.textColor = .pophoryBlack
        } else {
            infoLabel.textColor = .pophoryGray400
        }
    }
    
    // MARK: - Public Methods
    
    public func setupTitle(title: String) {
        mainLabel.text = title
    }
    
    public func setupSelected(selected: Bool) {
        changeInfoLabelColor(selected: selected)
    }
    
    public func setupIcon(icon: UIImage) {
        infoIcon.image = icon
    }
    
    public func setupExplain(explain: String) {
        infoLabel.text = explain
    }
}
