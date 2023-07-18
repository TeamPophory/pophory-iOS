//
//  ConstraintMaker.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/19.
//

import Foundation

import SnapKit

extension ConstraintMaker {
    public func aspectRatio(_ ratio: CGSize) {
        let view = item as! ConstraintView
        self.width.equalTo(view.snp.height).multipliedBy(ratio.width / ratio.height)
    }
}
