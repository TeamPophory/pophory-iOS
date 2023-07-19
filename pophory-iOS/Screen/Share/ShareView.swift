//
//  ShareView.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class ShareView: UIView {
    
    // MARK: - UI Properties
    
    private let sharePhotoView: UIView = {
        let view = UIView()
        view.makeRounded(radius: 20)
        view.layer.borderColor = UIColor.pophoryGray400.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowOffset = .init(width: 8, height: 8)
        return view
    }()
    
    let shareButton: PophoryButton = {
    let buttonBuilder = PophoryButtonBuilder()
    .setStyle(.primaryBlack)
    .setTitle(.share)
    return buttonBuilder.build()
    }()
    
    let shareImageView = UIImageView()

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareView {
    
    private func setupStyle() {
        self.backgroundColor = .pophoryWhite
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        self.addSubviews([shareButton, sharePhotoView])
        
        sharePhotoView.addSubviews([shareImageView])
        
        // TODO: - View 크기 유동적
        
        sharePhotoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(34)
            $0.bottom.equalTo(shareButton.snp.top).offset(-43)
        }
        
        shareButton.addCenterXConstraint(to: self)
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        // TODO: - 가로 세로 분기 처리
        
        shareImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(88)
            $0.bottom.equalToSuperview().inset(59)
        }
    }
    
}
