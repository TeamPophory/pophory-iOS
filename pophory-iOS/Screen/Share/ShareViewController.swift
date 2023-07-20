//
//  ShareViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class ShareViewController: UIViewController {
    
    // MARK: - Properties
    
    private var shareID: String? {
        didSet {
            if let shareID = shareID {
                requestGetSharePhotoAPI(shareID: shareID)
            }
        }
    }
    
    private var sharePhoto: PatchSharePhotoRequestDTO? {
        didSet {
            if let sharePhoto = sharePhoto {
                let url = URL(string: sharePhoto.imageUrl)
                rootView.shareImageView.kf.setImage(with: url)
                rootView.shareImageView.contentMode = .scaleAspectFit

            }
        }
    }
    
    // MARK: - UI Properties
    
    let rootView = ShareView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        setUpTarget()
    }
}

extension ShareViewController {
    
    private func setUpTarget() {
//        rootView.shareButton.addTarget(self, action: #selector(onClickSharedButton), for: .touchUpInside)
    }
    
    func setupShareID(forShareID: String?) {
        self.shareID = forShareID
    }
}

extension ShareViewController {
    func requestGetSharePhotoAPI(
        shareID: String
    ) {
        NetworkService.shared.shareRepository.patchSharePhoto(shareId: shareID) { result in
            switch result {
            case .success(let response):
                self.sharePhoto = response
            default : return
            }
        }
    }
}
