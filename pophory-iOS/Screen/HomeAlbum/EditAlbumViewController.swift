//
//  EditAlbumViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/19.
//

import UIKit

final class EditAlbumViewController: BaseViewController {
    
    private let editAlbumView = EditAlbumView()
    
    override func setupLayout() {
        view = editAlbumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PophoryNavigationConfigurator.shared.configureNavigationBar(in: self, navigationController: navigationController!, rightButtonImageType: .none)
        showNavigationBar()
    }
}

extension EditAlbumViewController: Navigatable {
    var navigationBarTitleText: String? { return "앨범 테마" }
}
