//
//  ChangeSortViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

protocol ConfigPhotoSortStyle {
    func configPhotoSortStyle(sortStyle: PhotoSortStyle)
}

final class ChangeSortViewController: BaseViewController {
    
    let changeSortView = ChangeSortView()
    
    private var photoSortStyle: PhotoSortStyle
    var configPhotoSortSyleDelegate: ConfigPhotoSortStyle?
    
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
        
        self.configPhotoSortSyleDelegate?.configPhotoSortStyle(sortStyle: self.photoSortStyle)
    }
    
    override func setupLayout() {
        view = changeSortView
    }
    
    private func setDelegate() {
        changeSortView.buttonTappedDelegate = self
    }
}

extension ChangeSortViewController: ChangeSortViewButtonTapped {
    func currentSortButtonTapped() {
        photoSortStyle = .current
        self.dismiss(animated: true)
    }
    
    func oldSortButtonTapped() {
        photoSortStyle = .old
        self.dismiss(animated: true)
    }
}
