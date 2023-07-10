//
//  FontLiterals.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UIFont {
    
    // MARK: - 이거 쓰세용
    
    @nonobjc class var head1Bold: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    @nonobjc class var head1Medium: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 24)
    }
    
    @nonobjc class var head2: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 20)
    }
    
    @nonobjc class var head3: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 18)
    }
    
    @nonobjc class var title1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 17)
    }
    
    @nonobjc class var text1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var caption1: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    @nonobjc class var caption2: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 12)
    }
    
    @nonobjc class var nav: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 12)
    }
    
    @nonobjc class var popupTitle: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 19)
    }
    
    @nonobjc class var popupText: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    @nonobjc class var popupButton: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var popupLine: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    @nonobjc class var modalTitle: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 28)
    }
    
    @nonobjc class var modalText: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    // TODO: 삭제예정 (사용 금지)

    @nonobjc class var h1: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    @nonobjc class var h1m: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 24)
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
    
    @nonobjc class var pTtl: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 19)
    }
    
    @nonobjc class var pTxt: UIFont {
        return UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    @nonobjc class var pBtn: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 16)
    }
    
    @nonobjc class var pL: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
    @nonobjc class var mTtl: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 28)
    }
    
    @nonobjc class var mTxt: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 18)
    }
}

enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
