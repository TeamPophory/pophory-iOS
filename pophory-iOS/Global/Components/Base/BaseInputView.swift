//
//  BaseInputView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

import SnapKit

class BaseSignUpView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NextButtonDelegate?
    
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
    
    let indicatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    let indicatorViews = [UIView(), UIView(), UIView()]
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIndicatorViews()
        setupViews()
        configureNextButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCharCountLabel(charCount: Int) {}
    
    func updateIndicatorViewBackgroundColor(at index: Int, color: UIColor) {
        guard index >= 0 && index < indicatorViews.count else {
            print("Invalid index.")
            return
        }
        indicatorViews[index].backgroundColor = color
    }
}

// MARK: - Extensions

extension BaseSignUpView {
    
    // MARK: - Layout
    
    private func setupViews() {
        
        addSubviews([headerLabel, indicatorStackView, nextButton])
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(convertByHeightRatio(32))
            make.leading.equalToSuperview().offset(convertByWidthRatio(20))
        }
        
        indicatorStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(convertByWidthRatio(6))
            make.height.equalTo(convertByHeightRatio(3))
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-10)
        }
    }
    
    func setupLayoutForAlbumCoverView(_ subView: UIView, topOffset: CGFloat) {
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(topOffset)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func onClickNextButton() {
        delegate?.onClickNextButton()
    }
    
    // MARK: - Methods
    
    private func configureNextButton() {
        nextButton.addTarget(self, action: #selector(onClickNextButton), for: .touchUpInside)
    }
    
    func setupNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
    
    private func setupIndicatorViews() {
        for view in indicatorViews {
            view.backgroundColor = .pophoryGray300
            
            view.snp.makeConstraints { make in
                make.width.equalTo(convertByWidthRatio(30))
                make.height.equalTo(convertByHeightRatio(3))
            }
            
            indicatorStackView.addArrangedSubview(view)
        }
    }
}
