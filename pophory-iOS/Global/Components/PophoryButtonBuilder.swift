//
//  PophoryButtonBuilder.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/30.
//

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

import UIKit

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
        button.titleLabel?.font = .head3
        button.backgroundColor = .black
    }
    
    public func handleStateChange(to button: PophoryButton) {
        if button.isEnabled {
            button.setTitleColor(.pophoryPurple, for: .normal)
        } else {
            button.setTitleColor(.pophoryGray400, for: .normal)
        }
    }
}

public struct PrimaryWhiteButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .head3
        button.backgroundColor = .pophoryWhite
        button.setTitleColor(.pophoryPurple, for: .normal)
    }
}

public struct SecondaryBlackButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .text1
    }
}

public struct SecondaryGrayButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = .t1
        button.backgroundColor = .pophoryGray200
        button.setTitleColor(.pophoryGray500, for: .normal)
    }
    
    public func handleStateChange(to button: PophoryButton) {
        if button.isEnabled {
            button.setTitleColor(.pophoryWhite, for: .normal)
        } else {
            button.setTitleColor(.pophoryGray400, for: .normal)
        }
    }
}

public func applyStyle(to button: PophoryButton) {
    button.titleLabel?.font = .t1
    button.backgroundColor = .pophoryGray400
    button.setTitleColor(.pophoryWhite, for: .normal)
}

public class PophoryButtonBuilder {
    private var buttonStyle: ButtonStyle?
    private var buttonTitle: ButtonText?
    private var size: CGSize?
    
    public func setStyle(_ style: ButtonStyle) -> PophoryButtonBuilder {
        self.buttonStyle = style
        self.size = style.size
        return self
    }
    
    public func setTitle(_ title: ButtonText) -> PophoryButtonBuilder {
        self.buttonTitle = title
        return self
    }
    
    public func setSize(_ size: CGSize) -> PophoryButtonBuilder {
        self.size = size
        return self
    }
    
    public func build(initiallyEnabled: Bool = true) -> PophoryButton {
        let buttonStyler = buttonStyle?.styler() ?? PrimaryBlackButtonStyler()
        let button = PophoryButton(style: buttonStyle ?? ButtonStyle.primaryBlack,
                                   text: buttonTitle ?? ButtonText.next,
                                   styler: buttonStyler,
                                   initiallyEnabled: initiallyEnabled)
        button.applyStyle()
        return button
    }
}
