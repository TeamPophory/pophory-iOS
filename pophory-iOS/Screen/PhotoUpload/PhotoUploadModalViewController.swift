//
//  PhotoUploadModalViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/08.
//

import UIKit

import SnapKit
import Photos

protocol PhotoUploadModalViewControllerDelegate: AnyObject {
    func didFinishPickingImage(_ image: UIImage)
}

class PhotoUploadModalViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var isAlbumFull: Bool = false
    
    private var imagePHPViewController = BasePHPickerViewController()
    private let limitedViewController = PHPickerLimitedPhotoViewController()
    
    var parentNavigationController: UINavigationController?
    var tabbarController: UITabBarController?
    
    
    weak var delegate: PhotoUploadModalViewControllerDelegate?
    
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
        button.setImage(ImageLiterals.qrUploadButton, for: .normal)
        button.addTarget(self, action: #selector(handleRegisterWithQrButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerWithAlbumButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.uploadFromAlbumButton, for: .normal)
        button.addTarget(self, action: #selector(handleRegisterWithAlbumButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        imagePHPViewController.delegate = self
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
        let qrNavigationController = PophoryNavigationController(rootViewController: qrScannerVC)
        
        self.dismiss(animated: true) { [weak self]  in
            qrNavigationController.modalPresentationStyle = .overFullScreen
            qrNavigationController.modalTransitionStyle = .crossDissolve
            self?.parentNavigationController?.present(qrNavigationController, animated: true)
        }
    }
    
    @objc func handleRegisterWithAlbumButton() {
        if isAlbumFull {
            showPopup(
                image: ImageLiterals.img_albumfull,
                primaryText: "포포리 앨범이 가득찼어요",
                secondaryText: "아쉽지만, 다음 업데이트에서 만나요!"
            )
        } else {
            imagePHPViewController.setupImagePermission()
        }
    }
    
    // MARK: - Custom Methods
    
    func dismissBottomSheet() {
        self.dismiss(animated: true)
    }
}

// MARK: - PHPickerProtocol

extension PhotoUploadModalViewController: PHPickerProtocol {
    func setupPicker() {
        DispatchQueue.main.async {
            guard let selectedImage = self.imagePHPViewController.pickerImage else { return }
            
            self.dismiss(animated: true)
            self.delegate?.didFinishPickingImage(selectedImage)
        }
    }
    
    func presentLimitedLibrary() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    func presentImageLibrary() {
        DispatchQueue.main.async {
            self.imagePHPViewController = BasePHPickerViewController()
            self.imagePHPViewController.delegate = self
            self.present(self.imagePHPViewController.phpickerViewController, animated: true)
        }
    }
    
    func presentDenidAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.deniedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedAlert() {
        DispatchQueue.main.async {
            self.present(self.imagePHPViewController.limitedAlert, animated: true, completion: nil)
        }
    }
    
    func presentLimitedImageView() {
        DispatchQueue.main.async {
            self.limitedViewController.setImageDummy(forImage: self.imagePHPViewController.fetchLimitedImages())
            self.navigationController?.pushViewController(self.limitedViewController, animated: true)
        }
    }
    
    func presentOverSize() {
        DispatchQueue.main.async {
            self.showPopup(popupType: .simple,
                           secondaryText: "사진의 사이즈가 너무 커서\n업로드할 수 없어요!")
        }
    }
}
