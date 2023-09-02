//
//  UserNameView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

class NameInputView: BaseSignUpView {
    
    // TODO: Private -> Delegate 패턴 구현
    
    var textFieldManager = TextFieldManager()
    
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = convertByWidthRatio(20)
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "한글 2-6자리 이내로 작성해주세요\n닉네임은 이후에 수정이 어려워요"
        label.textColor = .pophoryGray500
        label.font = .title1
        label.numberOfLines = 0
        //        label.setTextWithLineHeight(lineHeight: convertByHeightRatio(24))
        return label
    }()
    
    lazy var inputTextField: UITextField = { createInputTextField(placeholder: "닉네임", textFieldManager: textFieldManager) }()
    
    var charCountLabel: UILabel = {
        let label = UILabel()
        label.font = .popupButton
        label.textColor = .pophoryGray400
        label.text = "(0/6)"
        return label
    }()
    
    var warningLabel: UILabel = {
        let label = UILabel()
        label.font = .popupLine
        label.textColor = .pophoryRed
        label.text = "*6글자를 초과했습니다"
        label.isHidden = true
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDelegate()
        setupViews()
        updateIndicatorViewBackgroundColor(at: 0, color: .pophoryPurple)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension NameInputView {
    
    // MARK: - Layout
    
    private func setupViews() {
        
        addSubviews([bodyStackView, charCountLabel, warningLabel])
        bodyStackView.addArrangedSubviews([bodyLabel, inputTextField])
        
        bodyStackView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        inputTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        charCountLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(inputTextField)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(charCountLabel)
            $0.leading.equalToSuperview().offset(26)
        }
        
        inputTextField.addTarget(self, action: #selector(onValueChangedTextField), for: .editingChanged)
    }
    
    // MARK: - Private Methods
    
    private func setupDelegate() {
        inputTextField.delegate = textFieldManager
        textFieldManager.delegate = self
    }
}

extension NameInputView: TextFieldManagerDelegate {
    func updateBorderColor(to color: UIColor) {
        inputTextField.layer.borderColor = color.cgColor
    }
    
    func setWarningLabelHidden(isHidden: Bool) {
        warningLabel.isHidden = isHidden
    }
    
    func setCharCountLabelText(text: String) {
        charCountLabel.text = text
    }
    
    func setWarningLabelText(text: String) {
        warningLabel.text = text
    }
    
    func setNextButtonEnabled(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
}
