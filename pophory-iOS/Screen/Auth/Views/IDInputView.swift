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
        
        updateIndicatorViewBackgroundColor(at: 1, color: .pophoryPurple)
        updateIndicatorViewBackgroundColor(at: 0, color: .pophoryGray300)
        updateNameInputViewLabels()
        maxCharCount = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func updateNameInputViewLabels() {
        headerLabel.text = "너만의 재치있는\n포포리 아이디를 만들어줘!"
        headerLabel.applyColorAndBoldText(targetString: "포포리 아이디", color: .pophoryPurple, font: .head1Medium, boldFont: .head1Bold)
        bodyLabel.text = "영문, 숫자, 특수문자 조합 4-12자리 이내로\n작성해주세요 (특수문자는 . _ 만 가능해요)"
        inputTextField.placeholder = "아이디"
        charCountLabel.text = "(0/12)"
    }
    
    override func updateCharCountLabel(charCount: Int) {
        charCountLabel.text = "(\(charCount)/12)"
    }
}
