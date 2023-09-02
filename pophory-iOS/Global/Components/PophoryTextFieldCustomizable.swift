//
//  PophoryTextFieldCustomizable.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/24.
//

import UIKit

protocol PophoryTextFieldCustomizable: AnyObject {
    func createInputTextField(placeholder: String, textFieldManager: TextFieldManager) -> UITextField
    func createClearTextFieldButton(textFieldManager: TextFieldManager) -> UIButton
}

extension PophoryTextFieldCustomizable {
    func createInputTextField(placeholder: String, textFieldManager: TextFieldManager) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .black
        textField.backgroundColor = .pophoryGray100
        textField.font = .popupButton
        textField.layer.borderColor = UIColor.pophoryGray400.cgColor
        textField.layer.borderWidth = 1
        textField.makeRounded(radius: 18)
        textField.addPadding(left: 15)
        textField.addTarget(textFieldManager, action: #selector(textFieldManager.handleTextFieldEditingChanged), for: .editingChanged)
        textField.rightView = createClearTextFieldButton(textFieldManager: textFieldManager)
        textField.rightViewMode = .whileEditing
        return textField
    }
    
    func createClearTextFieldButton(textFieldManager: TextFieldManager) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(ImageLiterals.placeholderDeleteIcon, for: .normal)
        button.addTarget(textFieldManager, action: #selector(textFieldManager.handleTextFieldClearButton), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return button
    }
}
