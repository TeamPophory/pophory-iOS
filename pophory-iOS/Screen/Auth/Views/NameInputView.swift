//
//  UserNameView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit
import SnapKit

class NameInputView: UIView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "만나서 반가워\n너의 이름이 궁금해!"
        label.textColor = .black
        label.font = .h1
        label.numberOfLines = 0
        label.applyColorToString(targetString: "너의 이름", color: .pophoryPurple)
        //TODO: LineHeight적용
        return label
    }()
    
    let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        return stackView
    }()
    
    let bodyLabel: UILabel = {
        let normalFont = UIFont.t2
        let boldFont = UIFont.h3

        let label = UILabel()
        label.text = "포포리 사용을 위해 실명 입력이 필요해요"
        label.textColor = .pophoryGray500
        label.applyBoldTextTo("실명 입력", withFont: normalFont, boldFont: boldFont)
        return label
    }()

    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름(성+이름)"
        textField.textColor = .black
        textField.font = .t1
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 18
        textField.addPadding(left: 15)
        return textField
    }()
    
    let charCountLabel: UILabel = {
        let label = UILabel()
        label.font = .t1
        label.textColor = .pophoryGray400
        label.text = "(0/6)"
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.font = .c1
        label.textColor = .pophoryRed
        label.text = "*6글자를 초과했습니다"
        label.isHidden = true
        return label
    }()
    
    lazy var nextButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primary)
            .setTitle(.next)
        return buttonBuilder.build()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        setupDelegate()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension NameInputView {
    
    // MARK: - Layout
    
    private func setupViews() {
        addSubviews([headerLabel, bodyStackView, charCountLabel, nextButton, warningLabel])
        bodyStackView.addArrangedSubviews([bodyLabel, inputTextField])
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
            $0.leading.equalTo(bodyStackView)
        }
        
        bodyStackView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        inputTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        charCountLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(inputTextField)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(charCountLabel)
            $0.leading.equalToSuperview().offset(26)
        }
        
        nextButton.addCenterXConstraint(to: self)
    }
    
    // MARK: - @objc
    
    // MARK: - Private Methods
    
    private func setupDelegate() {
        inputTextField.delegate = self
    }
    
    func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/6)"
    }
}

// MARK: - UITextFieldDelegate

extension NameInputView: UITextFieldDelegate {
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            textField.layer.borderColor = UIColor.pophoryPurple.cgColor
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length

        if newLength > 6 {
            textField.layer.borderColor = UIColor.pophoryRed.cgColor
            warningLabel.isHidden = false
            return false
        } else {
            textField.textColor = .black
            textField.layer.borderColor = UIColor.pophoryPurple.cgColor
            warningLabel.isHidden = true
        }
        return true
    }

    @objc func textDidChange(_ textField: UITextField) {
        updateCharCountLabel(charCount: textField.text?.count ?? 0)
    }
}
