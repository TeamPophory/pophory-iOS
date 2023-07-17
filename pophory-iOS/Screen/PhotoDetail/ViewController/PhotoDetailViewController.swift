//
//  PhotoDetailViewController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

final class PhotoDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var photoID: Int?
    private var image: String?
    private var takenAt: String?
    private var studio: String?
    private var photoType: PhotoCellType?
    
    // MARK: - UI Properties
    
    private lazy var photoDetailView = PhotoDetailView(frame: .zero,
                                                       imageUrl: self.image ?? "",
                                                       takenAt: self.takenAt ?? "",
                                                       studio: self.studio ?? "",
                                                       type: photoType ?? PhotoCellType.vertical)
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        PophoryNavigationConfigurator.shared.configureNavigationBar(in: self, navigationController: navigationController!, rightButtonImageType: .delete)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = photoDetailView
    }
}

extension PhotoDetailViewController {
    
    @objc func rightButtonOnClick() {
        showPopup(popupType: .option,
                  primaryText: "사진을 삭제할까요?",
                  secondaryText: "지금 삭제하면 다시 볼 수 없어요",
                  firstButtonTitle: .delete,
                  secondButtonTitle: .back,
                  firstButtonHandler: deletePhoto,
                  secondButtonHandler: closePopup)
    }
    
    private func deletePhoto() {
        if let photoID = photoID {
            requestDeletePhoto(photoId: photoID)
        }
        dismiss(animated: false)
    }
    
    private func closePopup() {
        dismiss(animated: false)
    }
    
    func setData(photoID: Int, imageUrl: String, takenAt: String, studio: String, type: PhotoCellType) {
        self.photoID = photoID
        self.image = imageUrl
        self.takenAt = takenAt
        self.studio = studio
        self.photoType = type
    }
}

// MARK: - navigation bar

extension PhotoDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 사진" }
}

extension PhotoDetailViewController {
    func requestDeletePhoto(
        photoId: Int
    ) {
        NetworkService.shared.photoRepository.deletePhoto(
            photoId: photoId
        ) { result in
            switch result {
            case .success(let response):
                self.navigationController?.popViewController(animated: true)
            default : return
            }
        }
    }
}
