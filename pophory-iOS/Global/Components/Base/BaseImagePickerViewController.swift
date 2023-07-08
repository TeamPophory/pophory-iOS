//
//  BaseImagePickerViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/07.
//

import UIKit

import Photos

class BaseImagePickerViewController: UIImagePickerController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization({ status in
            switch status{
            case .authorized:
                print("앨범; 권한 허용")
            case .denied:
                print("앨범; 권한 거부")
            case .restricted, .notDetermined:
                print("선택하지 않음")
            default:
                print("default")
                break
            }
        })
    }
}
