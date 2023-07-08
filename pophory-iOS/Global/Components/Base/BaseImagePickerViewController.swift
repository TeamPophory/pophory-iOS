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
        
    }
    
    private func setupStyle() {
        self.sourceType = .photoLibrary
        self.allowsEditing = false
    }
}
