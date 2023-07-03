//
//  UILabel+Extension.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UILabel {
    
    /// 행간 조정 메서드
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    /// 선택된 텍스트의 색상 조정
    func applyColorToString(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    /// 선택된 텍스트 볼드처리
    func applyBoldTextTo(_ partOfString: String, withFont font: UIFont, boldFont: UIFont) {
        let normalText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: normalText, attributes: [NSAttributedString.Key.font: font])
        let boldRange = (normalText as NSString).range(of: partOfString)
        attributedString.setAttributes([NSAttributedString.Key.font: boldFont], range: boldRange)
        self.attributedText = attributedString
    }
}
