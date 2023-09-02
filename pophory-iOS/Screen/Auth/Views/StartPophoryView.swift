//
//  StartPophoryView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

import SnapKit

final class StartPophoryView: UIView {

    let ilustView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.congratuation
        return view
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "포포리 앨범을 만들었어!\n지금 사진을 추가해볼까?"
        label.font = .head1Medium
        label.textColor = .pophoryWhite
        label.numberOfLines = 0
//        label.setTextWithLineHeight(lineHeight: 34)
        return label
    }()
    
    let startButton: PophoryButton = {
        let buttonBuider = PophoryButtonBuilder()
            .setStyle(.primaryWhite)
            .setTitle(.startPophory)
        return buttonBuider.build()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension StartPophoryView {
    
    private func setupBackground() {
        self.backgroundColor = .pophoryPurple
    }
    
    private func setupLayout() {
        
        addSubviews([ilustView, startLabel, startButton])
        
        ilustView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(179)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(convertByWidthRatio(94))
            $0.size.equalTo(convertByWidthRatio(187))
        }
        
        startLabel.snp.makeConstraints {
            $0.top.equalTo(ilustView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(42)
        }
        
        startButton.addCenterXConstraint(to: self)
    }
}
