//
//  PickAlbumView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

protocol PickAlbumCoverViewDelegate: BaseSignUpViewDelegate {
    func didSelectAlbumButton(at index: Int)
}

// MARK: - PickAlbumCoverView

final class PickAlbumCoverView: BaseSignUpView {
    
    // MARK: - Properties
    
    private var lastSelectedItemIndex: IndexPath? = nil
    
    // MARK: - UI Properties
    
    private let albumCoverView = UIImageView(image: ImageLiterals.albumCover1)
    
    private lazy var selectButtonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRegister()
        setupLayoutForAlbumCoverView(albumCoverView, topOffset: 51)
        setupLayout()
        updateNameInputViewLabels()
        setupNextButtonEnabled(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeAlbumCover()
    }
}

//MARK: - Extensions

extension PickAlbumCoverView {
    
    // MARK: - Layout
    
    private func setupLayout() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeRight.direction = .right
        
        albumCoverView.addGestureRecognizer(swipeLeft)
        albumCoverView.addGestureRecognizer(swipeRight)
        albumCoverView.isUserInteractionEnabled = true
        
        addSubviews([albumCoverView, selectButtonCollectionView])
        
        albumCoverView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(convertByWidthRatio(220))
            $0.height.equalTo(convertByHeightRatio(298))
        }
        
        selectButtonCollectionView.snp.makeConstraints {
            $0.top.equalTo(albumCoverView.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(convertByWidthRatio(254))
            $0.height.equalTo(convertByHeightRatio(50))
        }
        
        initialAlbumSelection()
    }
    
    // MARK: - @objc
    
    @objc private func swipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            scrollAlbumCover(next: true)
        case .right:
            scrollAlbumCover(next: false)
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    
    private func updateNameInputViewLabels() {
        headerLabel.text = "마음에 쏙 드는\n앨범 테마를 선택해줘!"
        headerLabel.applyColorAndBoldText(targetString: "앨범 테마", color: .pophoryPurple, font: .head1Medium, boldFont: .head1Bold)
    }
    
    private func setupRegister() {
        selectButtonCollectionView.register(PickAlbumButtonCollectionViewCell.self, forCellWithReuseIdentifier: PickAlbumButtonCollectionViewCell.identifier)
    }
    
    private func shapeAlbumCover() {
        albumCoverView.shapeWithCustomCorners(topLeftRadius: 3, topRightRadius: 20, bottomLeftRadius: 3, bottomRightRadius: 20)
    }
    
    private func scrollAlbumCover(next: Bool) {
        guard let indexPath = lastSelectedItemIndex else { return }
        var item = indexPath.item
        var totalCount = selectButtonCollectionView.numberOfItems(inSection: 0)
        
        if next ? (item + 1 < totalCount) : (item - 1 >= 0) {
            item = next ? (item + 1) : (item - 1)
        } else {
            return
        }
        
        let newIndex = IndexPath(item: item, section: indexPath.section)
        collectionView(selectButtonCollectionView, didSelectItemAt: newIndex)
    }
    
    private func initialAlbumSelection() {
        let initialIndexPath = IndexPath(item: 0, section: 0)
        if let initialItem = selectButtonCollectionView.cellForItem(at: initialIndexPath) as? PickAlbumButtonCollectionViewCell {
            initialItem.isSelectedCell = true
        }
        lastSelectedItemIndex = initialIndexPath
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PickAlbumCoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: convertByWidthRatio(50), height: convertByHeightRatio(50))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return convertByWidthRatio(18)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (self.delegate as? PickAlbumCoverViewDelegate)?.didSelectAlbumButton(at: indexPath.item)
        if let lastSelected = lastSelectedItemIndex, let lastSelectedCell = collectionView.cellForItem(at: lastSelected) as? PickAlbumButtonCollectionViewCell {
            lastSelectedCell.isSelectedCell = false
        }
        
        if let currentItem = collectionView.cellForItem(at: indexPath) as? PickAlbumButtonCollectionViewCell {
            currentItem.isSelectedCell = true
        }
        
        lastSelectedItemIndex = indexPath
        albumCoverView.image = ImageLiterals.albumCoverList[indexPath.item + 1]
    }
}

// MARK: - UICollectionViewDataSource

extension PickAlbumCoverView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PickAlbumButtonCollectionViewCell.identifier, for: indexPath) as? PickAlbumButtonCollectionViewCell else { return UICollectionViewCell() }
        buttonCell.configureCell(forImage: ImageLiterals.albumCoverProfileList[indexPath.item + 1])
        return buttonCell
    }
}

extension PickAlbumCoverView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let indexPath = IndexPath(item: currentPage, section: 0)
        
        if let lastSelected = lastSelectedItemIndex, let lastSelectedCell = selectButtonCollectionView.cellForItem(at: lastSelected) as? PickAlbumButtonCollectionViewCell {
            lastSelectedCell.isSelectedCell = false
        }

        if let currentItem = selectButtonCollectionView.cellForItem(at: indexPath) as? PickAlbumButtonCollectionViewCell {
            currentItem.isSelectedCell = true
        }

        lastSelectedItemIndex = indexPath
        albumCoverView.image = ImageLiterals.albumCoverList[indexPath.item + 1]
    }
}
