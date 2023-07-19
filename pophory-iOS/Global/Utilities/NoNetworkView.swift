//
//  ServerFailViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/20.
//

import UIKit

import SnapKit

final class NoNetworkView: UIView {
    
    private let networkfailImageView = UIImageView(image: ImageLiterals.networkFail)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = .white
    }
    
    private func render() {
        self.addSubview(networkfailImageView)
    
        networkfailImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(248)
            $0.width.equalTo(196)
        }
    }
}
