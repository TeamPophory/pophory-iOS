//
//  ChangeSortViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

protocol ConfigPhotoSortStyleDelegate {
    func configPhotoSortStyle(by sortStyle: PhotoSortStyle)
}

final class ChangeSortViewController: BaseViewController {
    
    let changeSortView = ChangeSortView()
    
    private var photoSortStyle: PhotoSortStyle
    var configPhotoSortSyleDelegate: ConfigPhotoSortStyleDelegate?
    
    init(
        photoSortStyle: PhotoSortStyle
    ) {
        self.photoSortStyle = photoSortStyle
        self.changeSortView.configCheckImage(photoSortSytle: photoSortStyle)
        super.init(nibName: String(), bundle: Bundle())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.configPhotoSortSyleDelegate?.configPhotoSortStyle(by: self.photoSortStyle)
    }
    
    override func setupLayout() {
        view = changeSortView
    }
    
    private func setDelegate() {
        changeSortView.buttonTappedDelegate = self
    }
}

extension ChangeSortViewController: ChangeSortViewButtonTappedDelegate {
    func sortButtonTapped(
        by sortStyle: PhotoSortStyle
    ) {
        switch sortStyle {
        case .current:
            photoSortStyle = .current
        case .old:
            photoSortStyle = .old
        }
    }
}
