//
//  CarouselCollectionViewFlowLayout.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

class VerticalCarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let itemsCount = collectionView.numberOfItems(inSection: 0)

        // Imitating paging behaviour
        // Check previous offset and scroll direction
        if previousOffset > collectionView.contentOffset.y && velocity.y < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.y && velocity.y > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }

        // Update offset by using item size + spacing
        let updatedOffset = (itemSize.height + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset

        return CGPoint(x: proposedContentOffset.x, y: updatedOffset)
    }
}

class HorizontalCarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {

    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    private var moveSize: CGFloat = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let itemsCount = collectionView.numberOfItems(inSection: 0)

        // Imitating paging behaviour
        // Check previous offset and scroll direction
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }

        // Update offset by using item size + spacing
        let updatedOffset = (itemSize.width + minimumLineSpacing) * CGFloat(currentPage)
        moveSize = updatedOffset - previousOffset
        previousOffset = updatedOffset

        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
    
    func updateAfterDeletingLastCell() {
        currentPage -= 1
        previousOffset -= moveSize
    }
}
