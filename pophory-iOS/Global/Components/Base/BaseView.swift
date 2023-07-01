//
//  BaseView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
