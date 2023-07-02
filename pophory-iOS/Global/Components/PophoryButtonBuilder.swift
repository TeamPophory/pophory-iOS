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
         .setStyle(.primary)
         .setTitle(.next)
     return buttonBuilder.build()
 }()
 
 **/

public enum ButtonText: String {
    case next = "다음으로 넘어가기"
    case complete = "완료하기"
    case startPophory = "포포리 시작하기"
    case addPhoto = "사진 추가하기"
    case delete = "삭제할래!"
    case keep = "아니 안할래!"
}

public enum ButtonStyle {
    case primary
    case secondary
    
    var size: CGSize {
        switch self {
        case .primary:
            return CGSize(width: 335, height: 60)
        case .secondary:
            return CGSize(width: 230, height: 47)
        }
    }
}

public protocol PophoryButtonStyler {
    func applyStyle(to button: PophoryButton)
}

public struct PrimaryButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
}

public struct SecondaryButtonStyler: PophoryButtonStyler {
    public func applyStyle(to button: PophoryButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}

public class PophoryButtonBuilder {
    private var style: ButtonStyle = .primary
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
        let button = PophoryButton(style: self.style, text: self.title)
        return button
    }
}
