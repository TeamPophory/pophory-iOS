//
//  PickAlbumView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

class PickAlbumCoverView: NameInputView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        hideSuperViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: Delegate 이용해서 구현하기
    private func hideSuperViewComponents() {
        inputTextField.isHidden = true
        charCountLabel.isHidden = true
        warningLabel.isHidden = true
    }
    
    
}
