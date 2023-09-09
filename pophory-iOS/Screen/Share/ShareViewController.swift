//
//  ShareViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class ShareViewController: BaseViewController {
    
    // MARK: - Properties
    
    var errorBool: Bool?
    
    private var shareID: String? {
        didSet {
            if let shareID = shareID {
                ShareNetworkManager.shared.requestGetSharePhoto(shareID: shareID) { [weak self] response in
                    self?.sharePhoto = response
                    self?.errorBool = false
                } completionError: {
                    
                }
            }
        }
    }
    
    private var sharePhoto: FetchSharePhotoRequestDTO? {
        didSet {
            if let sharePhoto = sharePhoto {
                let url = URL(string: sharePhoto.imageUrl)
                rootView.shareImageView.kf.setImage(with: url)
                rootView.shareImageView.contentMode = .scaleAspectFit
                rootView.userNameLabel.text = sharePhoto.realName
                rootView.userIDLabel.text = "@" + sharePhoto.nickname
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
    }
}

extension ShareViewController {
    func setupShareID(forShareID: String?) {
        self.shareID = forShareID
    }
}

extension ShareViewController {
    func requestGetSharePhotoAPI(
        shareID: String
    ) {
        NetworkService.shared.shareRepository.fetchSharePhoto(shareId: shareID) { result in
            switch result {
            case .success(let response):
                self.sharePhoto = response
            default : return
            }
        }
    }
}
