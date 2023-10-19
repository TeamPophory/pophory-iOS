//
//  PhotoUploadModalViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/08.
//

import UIKit

import SnapKit

class PhotoUploadModalViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.font = .modalTitle
        label.text = "사진 등록하기"
        return label
    }()
    
    private let registerButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var registerWithQrButton: UIButton = {
        let button = UIButton()
        //        button.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
        button.backgroundColor = .pophoryGray300
        button.addTarget(self, action: #selector(handleRegisterWithQrButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerWithAlbumButton: UIButton = {
        let button = UIButton()
        //        button.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
        button.backgroundColor = .pophoryGray300
        button.addTarget(self, action: #selector(handleRegisterWithAlbumButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
}

// MARK: - Extensions

extension PhotoUploadModalViewController {
    
    // MARK: - Layout Helpers
    
    private func setLayout() {
        view.addSubviews([registerLabel, registerButtonsStackView])
        registerButtonsStackView.addArrangedSubviews([registerWithQrButton, registerWithAlbumButton])
        
        registerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        registerButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(registerLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(registerLabel)
            make.height.equalTo(120)
        }
    }
    
    // MARK: - Action Helpers
    @objc func handleRegisterWithQrButton() {
        let qrScannerVC = QRScannerViewController()
        let qrNavigationController = UINavigationController(rootViewController: qrScannerVC)
        
        qrNavigationController.modalPresentationStyle = .overFullScreen
        qrNavigationController.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.present(qrNavigationController, animated: true)
    }
    
    @objc func handleRegisterWithAlbumButton() {
        let imagePHPViewController = BasePHPickerViewController()
        
        imagePHPViewController.setupImagePermission()
    }
}
