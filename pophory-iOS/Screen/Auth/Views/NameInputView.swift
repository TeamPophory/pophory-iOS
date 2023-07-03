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
        label.asColor(targetString: "너의 이름", color: .pophoryPurple)
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
        let label = UILabel()
        label.text = "포포리 사용을 위해 실명 입력이 필요해요"
        label.textColor = .pophoryGray500
        //TODO: fontsize
        label.font = .t2
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "이름(성+이름)"
        textField.textColor = .black
        textField.font = .t1
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
    
    lazy var nextButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.primary)
            .setTitle(.next)
        return buttonBuilder.build()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameInputView {
    
    // MARK: - Layout
    
    private func setupViews() {
        addSubviews([headerLabel, bodyStackView, charCountLabel, nextButton])
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
        
        nextButton.addCenterXConstraint(to: self)
    }
    
    // MARK: - @objc
    
    // MARK: - Private Methods
    
    func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/6)"
    }
}

extension NameInputView: UITextFieldDelegate {
    
    @objc func textDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        updateCharCountLabel(charCount: text.count)
    }
}
