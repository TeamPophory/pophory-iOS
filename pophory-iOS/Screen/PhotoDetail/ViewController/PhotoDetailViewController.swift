//
//  PhotoDetailViewController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

final class PhotoDetailViewController: BaseViewController, Navigatable, ShareButtonDisplayable {
    
    // MARK: - Properties
    
    private var photoID: Int?
    private var image: String?
    private var takenAt: String?
    private var studio: String?
    private var photoType: PhotoCellType?
    
    // MARK: - UI Properties
    
    var navigationBarTitleText: String? { return "내 사진" }
    var shouldDisplayShareButton: Bool {
        return true
    }
    
    private lazy var photoDetailView = PhotoDetailView(frame: .zero,
                                                       imageUrl: self.image ?? "",
                                                       takenAt: self.takenAt ?? "",
                                                       studio: self.studio ?? "",
                                                       type: photoType ?? PhotoCellType.vertical)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared, showRightButton: true, rightButtonImageType: .delete)
        view = photoDetailView
    }
}

// MARK: - Extensions

extension PhotoDetailViewController {
    
    @objc func deleteButtonOnClick() {
        showPopup(popupType: .option,
                  primaryText: "사진을 삭제할까요?",
                  secondaryText: "지금 삭제하면 다시 볼 수 없어요",
                  firstButtonTitle: .back,
                  secondButtonTitle: .delete,
                  firstButtonHandler: deletePhoto,
                  secondButtonHandler: closePopup)
    }
    
    @objc func shareButtonOnClick() {
        
        guard let image = image else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, _, error) in
            // 공유 완료 후 필요한 처리
            if completed {
                print("사진 공유 완료")
            }
            
            if let error = error {
                print("사진 공유 오류: \(error.localizedDescription)")
            }
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(activityViewController, animated: true, completion: nil)
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

// MARK: - Network

extension PhotoDetailViewController {
    func requestDeletePhoto(
        photoId: Int
    ) {
        NetworkService.shared.photoRepository.deletePhoto(
            photoId: photoId
        ) { result in
            switch result {
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            default : return
            }
        }
    }
}
