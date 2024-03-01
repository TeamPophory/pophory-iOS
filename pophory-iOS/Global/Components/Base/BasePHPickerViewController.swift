//
//  BasePHPickerViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/12.
//

import UIKit

import PhotosUI
import Photos

class BasePHPickerViewController {
    
    // MARK: - Properties
    
    weak var delegate: PHPickerProtocol?
    
    var pickerImage: UIImage?
    
    private var fetchResult = PHFetchResult<PHAsset>()
    private var canAccessImages: [UIImage] = []
    private var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }
    
    lazy var phpickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 // 최대로 선택할 사진 및 영상의 개수
        
        // 라이브에 접근할 때 적용될 필터
        /// images, livePhotos, videos, any 존재함
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        return picker
    }()
    
    let deniedAlert: UIAlertController = {
        let titleMessage: String = "사진을 업로드하기 위해 설정을 눌러 사진 접근을 허용해주세요."
        let alert = UIAlertController(title: titleMessage, message: nil, preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "확인", style: .default)
        let confirm = UIAlertAction(title: "설정", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        
        alert.addAction(cancle)
        alert.addAction(confirm)
        return alert
    }()
    
    lazy var limitedAlert: UIAlertController = {
        let title: String = "pophory -ios 이(가) 사용자의 사진에 접근하려고 합니다."
        let message: String = "앱에 사진을 업로드하기 위해 사진 라이브러리에 엑세스를 허용합니다."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "더 많은 사진 선택", style: .default) { (UIAlertAction) in
            self.delegate?.presentLimitedLibrary()
        }
        let cancle = UIAlertAction(title: "현재 선택 항목 유지", style: .default) { (UIAlertAction) in
            self.delegate?.presentLimitedImageView()
        }
        
        alert.addAction(confirm)
        alert.addAction(cancle)
        
        return alert
    }()
    
    // MARK: - Method
    
    func setupImagePermission() {
        let requiredAccessLevel: PHAccessLevel = .readWrite
        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                self.delegate?.presentImageLibrary()
            case .limited:
                self.delegate?.presentLimitedImageView()
            case .denied:
                self.delegate?.presentDenidAlert()
            default:
                break
            }
        }
    }
    
    func fetchLimitedImages() -> [UIImage] {
        
        self.canAccessImages = []
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: self.thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(image)
                
            }
        }
        
        return canAccessImages
    }
}

// MARK: - PHPickerViewControllerDelegate

extension BasePHPickerViewController: PHPickerViewControllerDelegate {
    
    // 이미지 선택 완료 시 호출될 함수
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil) // 갤러리 dismiss
                
        let itemProvider = results.first?.itemProvider // result의 첫 번째 배열의 값 - ‼️ itemProvider
        
        if let itemProvider = itemProvider,                     // itemProvider가 존재하고,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // itemProvider가 불러온 이미지 값 가져올 수 있다면 실행
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                                
                guard let selectedImage = image as? UIImage else { return }
                print(selectedImage.megabytesSize)
                if selectedImage.megabytesSize <= 3.0 {
                    self.pickerImage = selectedImage
                    self.delegate?.setupPicker()
                } else {
                    self.delegate?.presentOverSize()
                }
            }
        }
    }
}
