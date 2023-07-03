//
//  UserNameView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit
import SnapKit

class NameInputView: UIView {
    
    let headerLabel = UILabel()
    let bodyStackView = UIStackView()
    let bodyLabel = UILabel()
    let inputTextField = UITextField()
    let charCountLabel = UILabel()
    let warningLabel = UILabel()
    
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
        setupStyle()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Style
    
    func setupStyle() {
        configureHeaderLabel()
        configureBodyStackView()
        configureBodyLabel()
        configureInputTextField()
        configureCharCountLabel()
        configureWarningLabel()
    }
    
    func configureHeaderLabel() {
        headerLabel.text = "만나서 반가워\n너의 이름이 궁금해!"
        headerLabel.textColor = .black
        headerLabel.font = .h1
        headerLabel.numberOfLines = 0
        headerLabel.asColor(targetString: "너의 이름", color: .pophoryPurple)
    }
    
    func configureBodyStackView() {
        bodyStackView.axis = .vertical
        bodyStackView.spacing = 16
        bodyStackView.distribution = .fill
        
        bodyStackView.addArrangedSubview(bodyLabel)
        bodyStackView.addArrangedSubview(inputTextField)
        bodyStackView.addArrangedSubview(charCountLabel)
        bodyStackView.addArrangedSubview(warningLabel)
    }
    
    func configureBodyLabel() {
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.text = "포포리 사용을 위해 실명 입력이 필요해요"
        bodyLabel.textColor = .pophoryGray500
        bodyLabel.font = .t2
        bodyLabel.numberOfLines = 0
        bodyLabel.applyBoldTextTo("실명 입력", withFont: .t2, boldFont: .h3)
    }
    
    func configureInputTextField() {
        inputTextField.placeholder = "이름(성+이름)"
        inputTextField.textColor = .black
        inputTextField.font = .t1
        inputTextField.layer.borderColor = UIColor.pophoryGray400.cgColor
        inputTextField.layer.borderWidth = 1
        inputTextField.makeRounded(radius: 18)
        inputTextField.addPadding(left: 15)
    }
    
    func configureCharCountLabel() {
        charCountLabel.translatesAutoresizingMaskIntoConstraints = false
        charCountLabel.font = .t1
        charCountLabel.textColor = .pophoryGray400
        charCountLabel.text = "(0/6)"
    }
    
    func configureWarningLabel() {
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.font = .t2
        warningLabel.textColor = .pophoryRed
        warningLabel.text = "*6글자를 초과했습니다"
        warningLabel.isHidden = true
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
