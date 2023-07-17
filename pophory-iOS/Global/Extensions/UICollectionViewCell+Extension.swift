//
//  UICollectionViewCell+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

extension UICollectionViewCell {
    func getCellIndexPath() -> IndexPath {
        let superView = self.superview as! UICollectionView
        guard let indexPath = superView.indexPath(for: self) else { return IndexPath() }
        return indexPath
    }
}

