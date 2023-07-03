//
//  UserNameView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit
import SnapKit

class NameInputView: BaseSignUpView {

    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()

    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "포포리 사용을 위해 실명 입력이 필요해요"
        label.textColor = .pophoryGray500
        label.font = .t2
        label.numberOfLines = 0
        label.applyBoldTextTo("실명 입력", withFont: .t2, boldFont: .h3)
        return label
    }()

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름(성+이름)"
        textField.textColor = .black
        textField.font = .t1
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
        textField.layer.borderWidth = 1
        textField.makeRounded(radius: 18)
        textField.addPadding(left: 15)
        return textField
    }()

    lazy var charCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .t1
        label.textColor = .pophoryGray400
        label.text = "(0/6)"
        return label
    }()

    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .t2
        label.textColor = .pophoryRed
        label.text = "*6글자를 초과했습니다"
        label.isHidden = true
        return label
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
