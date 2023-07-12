//
//  InputIDView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

final class IDInputView: NameInputView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateNameInputViewLabels()
        maxCharCount = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func updateNameInputViewLabels() {
        headerLabel.text = "너만의 재치있는\n포포리 아이디를 만들어줘!"
        headerLabel.asColor(targetString: "포포리 아이디", color: .pophoryPurple)
        bodyLabel.text = "영문, 숫자, 특수문자 조합 4-12자리 이내로 작성해요 (특수문자는 . _ 만 가능해요)"
        bodyLabel.applyBoldTextTo("4-12자리 이내", withFont: .t2, boldFont: .h3)
        inputTextField.placeholder = "아이디"
        charCountLabel.text = "(0/12)"
    }
    
    private func isValidCharacters(_ text: String) -> Bool {
        let regEx = "^[a-zA-Z0-9._]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
    override func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/12)"
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if self.isValidCharacters(newText) {
                textField.layer.borderColor = UIColor.pophoryPurple.cgColor
                self.warningLabel.isHidden = true
            } else {
                textField.layer.borderColor = UIColor.pophoryRed.cgColor
                self.warningLabel.text = "올바른 형식의 아이디가 아닙니다."
                self.warningLabel.isHidden = false
            }
        }
        
        return true
    }
}

extension IDInputView: UITextViewDelegate {
    
    @objc override func textFieldDidChangeSelection(_ textField: UITextField) {
        updateCharCountLabel(charCount: textField.text?.count ?? 0)
    }
}
