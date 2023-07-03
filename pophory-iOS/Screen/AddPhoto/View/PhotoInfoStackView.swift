//
//  PhotoInfoStackView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/03.
//

import UIKit

class PhotoInfoStackView: UIStackView {
    
    // MARK: - Properties
    
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
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray100
        view.makeRounded(radius: 18)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.pophoryGray300.cgColor
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트입니다."
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
        infoButton.setImage(icon, for: .normal)
    }
    
    public func setupExplain(explain: String) {
        infoLabel.text = explain
    }

}
