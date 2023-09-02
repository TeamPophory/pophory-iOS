//
//  UILabel+Extension.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UILabel {
    
    func setAttributedText(
        text: String,
        targetString: String,
        lineHeight: CGFloat,
        color: UIColor,
        font: UIFont,
        boldFont: UIFont
    ) {
        let defaultAttributes = setDefaultAttributes(lineHeight: lineHeight, font: font)
        let fullAttributedString = NSMutableAttributedString(string: text, attributes: defaultAttributes)
        
        let targetRange = (text as NSString).range(of: targetString)
        fullAttributedString.addAttribute(.foregroundColor, value: color, range: targetRange)
        fullAttributedString.addAttribute(.font, value: boldFont, range: targetRange)
        
        self.attributedText = fullAttributedString
        self.numberOfLines = 0
    }
    
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
    
    func setTextWithLineHeight(lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    /// 선택된 텍스트의 색상 조정
    func asColor(targetString: String, color: UIColor) {
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

    func applyColorAndBoldText(targetString: String, color: UIColor, font: UIFont, boldFont: UIFont) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)

        let targetRange = (fullText as NSString).range(of: targetString)

        // 색상 변경
        attributedString.addAttribute(.foregroundColor, value: color, range: targetRange)

        // 볼드 적용
        attributedString.addAttribute(.font, value: boldFont, range: targetRange)

        attributedText = attributedString
    }

}
