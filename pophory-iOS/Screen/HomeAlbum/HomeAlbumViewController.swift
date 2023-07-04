//
//  HomeAlbumViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

final class HomeAlbumViewController: BaseViewController {
    
    let homeAlbumView = HomeAlbumView(statusLabelText: String())
    private var albumList: PatchAlbumListResponseDTO? {
        didSet {
            if let photoCount = albumList?.albums?[0].photoCount {
                homeAlbumView.statusLabelText = String(photoCount)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetAlumListAPI()
    }
    
    override func setupLayout() {
        view = homeAlbumView
    }
}

extension HomeAlbumViewController  {
    func requestGetAlumListAPI() {
        NetworkService.shared.albumRepository.patchAlbumList() { result in
            switch result {
            case .success(let response):
                self.albumList = response
            default : return
            }
        }
    }
}
