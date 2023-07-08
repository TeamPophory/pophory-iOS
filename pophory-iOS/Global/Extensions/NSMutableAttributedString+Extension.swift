//
//  NSMutableAttributedString+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension NSMutableAttributedString {
    
    func regular(_ value: String,
                 font: UIFont = UIFont.t1,
                 color: UIColor? = nil) -> NSMutableAttributedString {
        
        var attributes:[NSAttributedString.Key : Any] = [
            .font : font,
        ]
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        
        return self
    }
    
    func underlined(_ value: String, _ size: CGFloat) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  UIFont.systemFont(ofSize: size),
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func link(text: String, url: String, _ size: CGFloat, _ weight: UIFont.Weight = .bold, _ color: UIColor = .blue) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font :  UIFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor : color,
            .link : url,
        ]
        
        let linkText = NSMutableAttributedString(string: text, attributes: attributes)
        linkText.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: linkText.length))
        
        self.append(linkText)
        
        return self
    }
}
