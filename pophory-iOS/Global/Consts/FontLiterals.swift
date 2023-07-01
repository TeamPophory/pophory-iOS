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
        return UIFont.font(.pretendardSemiBold, ofSize: 20)
    }
    
    @nonobjc class var h3: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 18)
    }
    
    @nonobjc class var ttl1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 17)
    }
    
    @nonobjc class var t1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var t2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    @nonobjc class var c1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    @nonobjc class var c2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
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
