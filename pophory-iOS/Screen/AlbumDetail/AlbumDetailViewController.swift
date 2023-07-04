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
        
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    private func setButtonAction() {
        homeAlbumView.sortButton.addTarget(self, action: #selector(sortButtonDidTapped), for: .touchUpInside)
    }
    
    @objc
    private func sortButtonDidTapped() {
        self.presentChangeSortViewController()
    }
    
    private func presentChangeSortViewController() {
        let changeSortViewController = ChangeSortViewController()
        changeSortViewController.modalPresentationStyle = .custom
        
        let yOffset: CGFloat = 222
        changeSortViewController.view.frame = CGRect(x: 0, y: yOffset, width: view.frame.width, height: yOffset)
        self.present(changeSortViewController, animated: true)
    }
}

extension AlbumDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 앨범" }
}
