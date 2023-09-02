//
//  PophoryHeaderLabelCustomizable.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/09/03.
//

import UIKit

protocol PophoryHeaderLabelCustomizable {
    func createHeaderLabel(text: String, lineHeight: CGFloat, font: UIFont, targetString: String, color: UIColor, boldFont: UIFont) -> UILabel
}

extension PophoryHeaderLabelCustomizable {
    func createHeaderLabel(text: String, lineHeight: CGFloat, font: UIFont, targetString: String, color: UIColor, boldFont: UIFont) -> UILabel {
        let label = UILabel()
        label.setAttributedText(text: text, targetString: targetString, lineHeight: lineHeight, color: color, font: font, boldFont: boldFont)
        return label
    }
}
