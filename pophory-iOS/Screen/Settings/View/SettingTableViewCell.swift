//
//  SettingTableViewCell.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/08.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: SettingTableViewCell.self)
    
    private lazy var titleLabel: UILabel = { createTitleLabel() }()
    private lazy var chevronImageView: UIImageView = { UIImageView(image: ImageLiterals.chevronRightIcon) }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SettingTableViewCell {
    private func setupLayout() {
        contentView.addSubviews([
            titleLabel,
            chevronImageView
        ])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.font = .t1
        label.textColor = .pophoryBlack
        label.text = "adfad"
        
        return label
    }
    
    func configCell(title: String) {
        titleLabel.text = title
    }
}
