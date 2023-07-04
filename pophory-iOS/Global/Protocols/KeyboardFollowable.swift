//
//  KeyboardFollowable.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/04.
//

import UIKit

protocol KeyboardFollowable: AnyObject {
    func setupKeyboardObservers()
    func removeKeyboardObservers()
}
