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
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "포포리 사용을 위해 실명 입력이 필요해요"
        label.textColor = .black
        //TODO: 확인 필요
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
        //        label.text = "(\()/6)"
        label.textColor = .gray
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameInputView {
    
    private func setupViews() {
        addSubviews([headerLabel,bodyLabel, inputTextField, nextButton])
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(10)
            $0.leading.equalTo(headerLabel)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(headerLabel)
            $0.width.equalTo(nextButton)
            $0.height.equalTo(60)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        nextButton.addCenterXConstraint(to: self)
    }
}
