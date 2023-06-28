//
//  UIScreen+Extension.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UIScreen {
    
    var hasNotch: Bool {
        return !( (UIScreen.main.bounds.width / UIScreen.main.bounds.height) > 0.5 )
    }
    
    /// Constraint 설정 시 노치 유무로 기기를 대응하는 상황에서 사용
    func constraintByNotch(_ hasNotch: CGFloat, _ noNotch: CGFloat) -> CGFloat {
        return UIScreen.main.hasNotch ? hasNotch : noNotch
    }
    
    /// 노치 유무에 따른 상단 Status Bar 부분 크기에 따른 높이
    func headerHeightByNotch(_ height: CGFloat) -> CGFloat {
        return (UIScreen.main.hasNotch ? 44 : 10) + height
    }
    
    func getDeviceWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getDeviceHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
