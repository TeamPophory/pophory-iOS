//
//  TextFieldManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/24.
//

import UIKit

final class TextFieldManager: NSObject {
    
    weak var delegate: TextFieldManagerDelegate?
    
    var maxCharCount: Int = 6
    
}

//MARK: - Extensions

extension TextFieldManager {
    
    // MARK: - @objc
    
    @objc func onClickClearTextFieldButton(_ textField: UITextField) {
        textField.text = nil
    }
    
    @objc func handleTextFieldEditingChanged(_ textField: UITextField) {
        textFieldDidChangeSelection(textField)
    }

    @objc func handleTextFieldClearButton(_ textField: UITextField) {
        textField.text = ""
        textFieldDidChangeSelection(textField)
    }
    
    // MARK: - Private Methods
    
    private func updateUIWithValidStatus(valid: Bool) {
        let borderColor: UIColor = valid ? .pophoryPurple : .pophoryRed
        delegate?.updateBorderColor(to: borderColor)
    }
    
    private func handleNextButtonStatus(charCount: Int, minCharCount: Int, maxCharCount: Int) {
        delegate?.updateBorderColor(to: .pophoryPurple)
        
        if charCount >= minCharCount && charCount <= maxCharCount {
            delegate?.setWarningLabelHidden(isHidden: true)
            delegate?.setNextButtonEnabled(isEnabled: true)
        } else {
            delegate?.setWarningLabelHidden(isHidden: false)
            delegate?.setNextButtonEnabled(isEnabled: false)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            delegate?.updateBorderColor(to: .pophoryPurple)
        } else {
            if !textField.text!.isContainKoreanOnly() {
                delegate?.updateBorderColor(to: .pophoryRed)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updateBorderColor(to: .pophoryGray400)
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldManager: UITextFieldDelegate  {
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        let charCount = text.count
        let countLabelText = "(\(charCount)/\(maxCharCount))"
        delegate?.setCharCountLabelText(text: countLabelText)

        let isTextFieldEmpty = text.isEmpty
        textField.rightView?.isHidden = isTextFieldEmpty

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if text.isContainKoreanOnly() {
                textField.layer.borderColor = UIColor.pophoryPurple.cgColor

                if text.count >= 2 && text.count <= 6 {
                    self.delegate?.setWarningLabelHidden(isHidden: true)
                    self.delegate?.setNextButtonEnabled(isEnabled: true)
                } else {
                    self.delegate?.setWarningLabelText(text: "2-6글자 이내로 작성해주세요")
                    self.delegate?.setWarningLabelHidden(isHidden: false)
                    self.delegate?.setNextButtonEnabled(isEnabled: false)
                }

            } else {
                textField.layer.borderColor = UIColor.pophoryRed.cgColor
                self.delegate?.setWarningLabelText(text: "현재 한국어만 지원하고 있어요")
                self.delegate?.setWarningLabelHidden(isHidden: false)
                self.delegate?.setNextButtonEnabled(isEnabled: false)
            }
        }
    }
}
