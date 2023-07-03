//
//  AlbumDetailViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

final class AlbumDetailViewController: BaseViewController {
    
    let homeAlbumView = AlbumDetailView()
    
    override func viewDidLoad() {
        view = homeAlbumView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
}

extension AlbumDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 앨범" }
}
