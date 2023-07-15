//
//  PophoryButtonBuilder.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/30.
//

import UIKit

/***
 생성 예시:
 
 lazy var nextButton: PophoryButton = {
 let buttonBuilder = PophoryButtonBuilder()
 .setStyle(.primaryBlack)
 .setTitle(.next)
 return buttonBuilder.build()
 }()
 
 레이아웃:
 - y축 설정 후 addCenterXConstraint 호출
 
 func setupLayout() {
 
 nextButton.snp.makeConstraints {
 $0.bottom.equalToSuperview().inset(36)
 }
 
 nextButton.addCenterXConstraint(to: self)
 
 }
 
 **/

public enum ButtonText: String {
    /// "다음으로 넘어가기"
    case next = "다음으로 넘어가기"
    
    /// "완료하기"
    case complete = "완료하기"
    
    /// "포포리 시작하기"
    case startPophory = "포포리 시작하기"
    
    /// "사진 추가하기"
    case addPhoto = "사진 추가하기"
    
    /// "삭제하기"
    case delete = "삭제하기"
    
    /// "Apple ID로 시작하기"
    case startWithAppleID = "Apple ID로 시작하기"
    
    /// "확인"
    case confirm = "확인"
    
    /// "돌아가기"
    case back = "돌아가기"
    
    /// "로그아웃하기"
    case logout = "로그아웃하기"
    
    /// "아쉽지만, 탈퇴하기"
    case deleteAccount = "아쉽지만, 탈퇴하기"
}

public enum ButtonStyle {
    case primaryBlack
    case primaryWhite
    case secondaryBlack
    case secondaryGray
    
    func styler() -> PophoryButtonStyler? {
        switch self {
        case .primaryBlack:
            return PrimaryBlackButtonStyler()
        case .primaryWhite:
            return PrimaryWhiteButtonStyler()
        case .secondaryBlack:
            return SecondaryBlackButtonStyler()
        case .secondaryGray:
            return SecondaryGrayButtonStyler()
        }
    }
    
    var size: CGSize {
        switch self {
        case .primaryBlack, .primaryWhite:
            return CGSize(width: 335, height: 60)
        case .secondaryBlack, .secondaryGray:
            return CGSize(width: 230, height: 47)
        }
    }
}

public protocol PophoryButtonStyler {
    func applyStyle(to button: PophoryButton)
}

public struct PrimaryBlackButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .h3
        button.backgroundColor = .black
    }
}

public struct PrimaryWhiteButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .h3
        button.backgroundColor = .pophoryWhite
        button.setTitleColor(.pophoryPurple, for: .normal)
    }
}

public struct SecondaryBlackButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .t1
    }
}

public struct SecondaryGrayButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .t1
        button.backgroundColor = .pophoryGray200
        button.setTitleColor(.pophoryGray500, for: .normal)
    }
}


public class PophoryButtonBuilder {
    private var style: ButtonStyle = .primaryBlack
    private var title: ButtonText = .next
    private var size: CGSize = .zero
    
    public func setStyle(_ style: ButtonStyle) -> PophoryButtonBuilder {
        self.style = style
        self.size = style.size
        return self
    }
    
    public func setTitle(_ title: ButtonText) -> PophoryButtonBuilder {
        self.title = title
        return self
    }
    
    public func setSize(_ size: CGSize) -> PophoryButtonBuilder {
        self.size = size
        return self
    }
    
    public func build() -> PophoryButton {
        let styler = style.styler()
        let button = PophoryButton(style: self.style, text: self.title, styler: styler)
        return button
    }
}
