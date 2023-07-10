//
//  InputIDView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

final class IDInputView: NameInputView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateNameInputViewLabels()
        maxCharCount = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateNameInputViewLabels() {
        headerLabel.text = "너만의 재치있는\n포포리 아이디를 만들어줘!"
        headerLabel.asColor(targetString: "포포리 아이디", color: .pophoryPurple)
        bodyLabel.text = "영문, 숫자, 특수문자 조합 4-12자리 이내로 작성해요 (특수문자는 . _ 만 가능해요)"
        bodyLabel.applyBoldTextTo("4-12자리 이내", withFont: .t2, boldFont: .h3)
        inputTextField.placeholder = "아이디"
        charCountLabel.text = "(0/12)"
        warningLabel.text = "*사용 불가능한 특수문자입니다"
    }
    
    override func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/12)"
    }
}

extension IDInputView: UITextViewDelegate {
    
    @objc override func textDidChange(_ textField: UITextField) {
        updateCharCountLabel(charCount: textField.text?.count ?? 0)
    }
}
