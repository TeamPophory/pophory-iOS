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
    
    private var styler: PophoryButtonStyler?
    
    private var buttonStyle: ButtonStyle
    private var buttonTitle: String
    private var buttonSize: CGSize
    private let buttonBackgroundColor: UIColor = .pophoryBlack
    private let disabledButtonBackgroundColor: UIColor = .pophoryGray400
    private let buttonTitleColor: UIColor = .white
    private var buttonFont: UIFont
    
    // MARK: - Life Cycle
    
    public init(style: ButtonStyle, text: ButtonText, styler: PophoryButtonStyler? = nil) {
        self.buttonStyle = style
        self.buttonTitle = text.rawValue
        self.buttonSize = style.size
        
        var tempCornerRadius: CGFloat = 0.0
        
        switch style {
        case .primaryBlack, .primaryWhite:
            self.buttonFont = .t1
            tempCornerRadius = 30
        case .secondaryBlack, .secondaryGray:
            self.buttonFont = .t1
            tempCornerRadius = 25
        }
        
        super.init(frame: CGRect(origin: CGPoint.zero, size: buttonSize))
        self.setupPophoryButton()
        self.layer.cornerRadius = tempCornerRadius
        
        styler?.applyStyle(to: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    // MARK: - @objc
    
    @objc private func buttonStateChanged() {
        backgroundColor = isEnabled ? buttonBackgroundColor : disabledButtonBackgroundColor
    }
    
    // MARK: - Private Methods
    
    private func setupPophoryButton() {
        setTitle(buttonTitle, for: .normal)
        setTitleColor(buttonTitleColor, for: .normal)
        setTitleColor(.lightGray, for: .disabled)
        backgroundColor = buttonBackgroundColor
        titleLabel?.font = buttonFont
        
        addTarget(self, action: #selector(buttonStateChanged), for: .allEvents)
    }
}
