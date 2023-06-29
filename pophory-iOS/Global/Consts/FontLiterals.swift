//
//  FontLiterals.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UIFont {
    @nonobjc class var h1: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 24)
    }
    
    @nonobjc class var h2: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 22)
    }
    
    @nonobjc class var h3: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 20)
    }
    
    @nonobjc class var t1: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 18)
    }
    
    @nonobjc class var t2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    @nonobjc class var b1: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    @nonobjc class var tg1: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 14)
    }
}

enum FontName: String {
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
