//
//  PHPickerProtocol.swift
//  pophory-iOS
//
//  Created by 강윤서 on 3/2/24.
//

import UIKit
import Photos

protocol PHPickerProtocol where Self: UIViewController {
    func setupPicker()
    func presentLimitedLibrary()
    func presentImageLibrary()
    func presentDenidAlert()
    func presentLimitedAlert()
    func presentLimitedImageView()
    func presentOverSize()
    
    var imagePHPViewController: BasePHPickerViewController { get set }
    var limitedViewController: PHPickerLimitedPhotoViewController { get }
}

extension PHPickerProtocol {
    
    var limitedViewController: PHPickerLimitedPhotoViewController {
        let limitedVC = PHPickerLimitedPhotoViewController()
        return limitedVC
    }
    
    var imagePHPViewController: BasePHPickerViewController {
        let imgPHPVC = BasePHPickerViewController()
        return imgPHPVC
    }
    
    func setupPicker() {
        DispatchQueue.main.async {
            guard let selectedImage = self.imagePHPViewController.pickerImage else { return }
            
            let secondViewController = AddPhotoViewController()
            
            var imageType: PhotoCellType = .vertical
            
            if selectedImage.size.width > selectedImage.size.height {
                imageType = .horizontal
            } else {
                imageType = .vertical
            }
            
            secondViewController.setupRootViewImage(forImage: selectedImage, forType: imageType)
            self.navigationController?.pushViewController(secondViewController, animated: true)
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
