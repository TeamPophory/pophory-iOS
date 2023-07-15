//
//  PophoryButton.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/30.
//

import UIKit
import SnapKit

public class PophoryButton: UIButton {
    
    // MARK: - Properties
    
    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? buttonBackgroundColor : disabledButtonBackgroundColor
        }
    }
    
    private var styler: PophoryButtonStyler?
    
    private var buttonStyle: ButtonStyle
    private var buttonTitle: String
    private var buttonSize: CGSize
    private let buttonBackgroundColor: UIColor = .pophoryBlack
    private let disabledButtonBackgroundColor: UIColor = .pophoryGray400
    private let buttonTitleColor: UIColor = .white
    private var buttonFont: UIFont
    
    // MARK: - Life Cycle
    
    public init(style: ButtonStyle, text: ButtonText, styler: PophoryButtonStyler? = nil, initiallyEnabled: Bool = true) {
        self.styler = styler
        self.buttonStyle = style
        self.buttonTitle = text.rawValue
        self.buttonSize = style.size
        
        var tempCornerRadius: CGFloat = 0.0
        
        switch style {
        case .primaryBlack, .primaryWhite:
            self.buttonFont = .text1
            tempCornerRadius = 30
        case .secondaryBlack, .secondaryGray:
            tempCornerRadius = 23.5
            self.buttonFont = .text1
        }
        
        super.init(frame: CGRect(origin: CGPoint.zero, size: buttonSize))
        self.setupPophoryButton()
        self.layer.cornerRadius = tempCornerRadius
        isEnabled = initiallyEnabled
        backgroundColor = initiallyEnabled ? buttonBackgroundColor : disabledButtonBackgroundColor
        
        applyStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? buttonBackgroundColor : disabledButtonBackgroundColor
            setTitleColor(buttonTitleColor, for: .disabled) // disabled 되었을 때도 default disabled title 색이 아닌 우리가 정한 색으로 바뀌도록
        }

    public func applyStyle() {
        styler?.applyStyle(to: self)
    }
}

// MARK: - Extension

extension PophoryButton {
    
    // MARK: - Layout
    
    func addCenterXConstraint(to view: UIView) {
        snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.width.equalTo(buttonSize.width)
            $0.height.equalTo(buttonSize.height)
        }
    }
    
    func addCenterConstraint(to view: UIView) {
        view.addSubview(self)
        
        snp.makeConstraints {
            $0.center.equalTo(view)
            $0.width.equalTo(buttonSize.width)
            $0.height.equalTo(buttonSize.height)
        }
    }
    
    func applySize() {
        snp.makeConstraints { make in
            make.width.equalTo(buttonSize.width)
            make.height.equalTo(buttonSize.height)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupPophoryButton() {
        setTitle(buttonTitle, for: .normal)
        setTitleColor(buttonTitleColor, for: .normal)
        setTitleColor(.lightGray, for: .disabled)
        backgroundColor = buttonBackgroundColor
        titleLabel?.font = buttonFont
    }
}
