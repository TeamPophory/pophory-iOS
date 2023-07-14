//
//  UserNameView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit
import SnapKit

class NameInputView: BaseSignUpView {
    
    var maxCharCount:Int = 6
    
    // TODO: Private -> Delegate 패턴 구현
    
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
        label.text = "원활한 포포리 사용을 위해 실명 입력이 필요해요"
        label.textColor = .pophoryGray500
        label.font = .title1
        label.numberOfLines = 0
        label.setTextWithLineHeight(lineHeight: 24)
        return label
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.textColor = .black
        textField.backgroundColor = .pophoryGray100
        textField.font = .popupButton
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
        textField.layer.borderWidth = 1
        textField.makeRounded(radius: 18)
        textField.addPadding(left: 15)
        
        let clearTextFieldIcon: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(ImageLiterals.placeholderDeleteIcon, for: .normal)
            button.addTarget(self, action: #selector(clearTextFieldTapped), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: convertByWidthRatio(15))
            return button
        }()
        
        textField.rightView = clearTextFieldIcon
        textField.rightViewMode = .always
        
        return textField
    }()
    
    @objc private func clearTextFieldTapped() {
        inputTextField.text = ""
    }
    
    
    lazy var charCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .popupButton
        label.textColor = .pophoryGray400
        label.text = "(0/6)"
        return label
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .popupLine
        label.textColor = .pophoryRed
        label.text = "*6글자를 초과했습니다"
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputTextField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        setupDelegate()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/6)"
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
    
    @objc func clearTextFieldButtonOnClick() {
        inputTextField.text = nil
    }
    
    // MARK: - Private Methods
    
    private func setupDelegate() {
        inputTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension NameInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            textField.layer.borderColor = UIColor.pophoryPurple.cgColor
        } else {
            if !textField.text!.isContainKoreanOnly() {
                textField.layer.borderColor = UIColor.pophoryRed.cgColor
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldText = textField.text, let stringRange = Range(range, in: oldText) {
            let newText = oldText.replacingCharacters(in: stringRange, with: string)
            let newLength = newText.count
            
            if newLength > 6 {
                textField.layer.borderColor = UIColor.pophoryRed.cgColor
                warningLabel.text = "2-6글자 이내로 작성해주세요."
                warningLabel.isHidden = false
                return false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                if newText.isContainKoreanOnly() {
                    textField.layer.borderColor = UIColor.pophoryPurple.cgColor
                    self.warningLabel.isHidden = true
                } else {
                    textField.layer.borderColor = UIColor.pophoryRed.cgColor
                    self.warningLabel.text = "현재 한국어만 지원하고 있어요."
                    self.warningLabel.isHidden = false
                }
            }
        }
        
        return true
    }
    
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        updateCharCountLabel(charCount: textField.text?.count ?? 0)
    }
}
