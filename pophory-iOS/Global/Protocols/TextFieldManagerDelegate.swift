//
//  TextFieldUpdatable.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/08/09.
//

import UIKit

protocol TextFieldManagerDelegate: AnyObject {
    func updateBorderColor(to color: UIColor)
    func setWarningLabelHidden(isHidden: Bool)
    func setCharCountLabelText(text: String)
    func setWarningLabelText(text: String)
    func setNextButtonEnabled(isEnabled: Bool)
}


