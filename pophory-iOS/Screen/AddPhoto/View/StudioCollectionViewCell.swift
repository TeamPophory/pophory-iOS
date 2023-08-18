//
//  StudioCollectionViewCell.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/06.
//

import UIKit

class StudioCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "StudioCell"
    
    //    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedCell()
            } else {
                unSelectedCell()
            }
        }
    }
    
    // MARK: - UI Properties
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .pophoryGray200
        view.makeRounded(radius: 20)
        return view
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .text1
        label.text = "인생네컷"
        label.textColor = .pophoryGray500
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StudioCollectionViewCell {
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellView.addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Method
    
    func configureCell(text: String) {
        cellLabel.text = text
    }
    
    func selectedCell() {
        cellView.backgroundColor = .pophoryBlack
        cellLabel.textColor = .pophoryWhite
    }
    
    func unSelectedCell() {
        cellView.backgroundColor = .pophoryGray200
        cellLabel.textColor = .pophoryGray500
    }
}
