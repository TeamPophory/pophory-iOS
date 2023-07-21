//
//  BaseInputView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit
import SnapKit

protocol BaseSignUpViewDelegate: AnyObject {
    func didTapBaseNextButton()
}

class BaseSignUpView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: BaseSignUpViewDelegate?
    
    // MARK: - UI Properties
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "포포리에서 사용할\n너의 닉네임을 알려줘!"
        label.textColor = .black
        label.font = .head1Medium
        label.numberOfLines = 0
        label.setTextWithLineHeight(lineHeight: 34)
        label.applyColorAndBoldText(targetString: "너의 닉네임", color: .pophoryPurple, font: .head1Medium, boldFont: .head1Bold)
        return label
    }()
    
    lazy var nextButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.next)
            .build(initiallyEnabled: false)
        
        buttonBuilder.applySize()
        return buttonBuilder
    }()
    
    private lazy var indicatorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupBaseNextButton()
        setupViews()
        setupRegister()
        setupNextButtonEnabled(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCharCountLabel(charCount: Int) {}
}

// MARK: - Extensions

extension BaseSignUpView {
    
    // MARK: - Layout
    
    private func setupViews() {
        
        addSubviews([headerLabel, indicatorCollectionView, nextButton])

        headerLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(convertByWidthRatio(20))
        }
        
        indicatorCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(convertByWidthRatio(6))
            $0.height.equalTo(convertByHeightRatio(3))
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            if #available(iOS 15.0, *) {
                $0.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-10)
            }
        }
    }

    func setupLayoutForAlbumCoverView(_ subView: UIView, topOffset: CGFloat) {
        addSubview(subView)
        subView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(topOffset)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setupNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }

    
    // MARK: - @objc
    
    @objc func didTapBaseNextButton() {
        self.delegate?.didTapBaseNextButton()
    }
    
    // MARK: - Private Methods
    
    private func setupBaseNextButton() {
        nextButton.addTarget(self, action: #selector(didTapBaseNextButton), for: .touchUpInside)
    }
    
    private func setupRegister() {
        indicatorCollectionView.register(SignUpIndicatorCollectionViewCell.self, forCellWithReuseIdentifier: SignUpIndicatorCollectionViewCell.identifier)
    }
}
