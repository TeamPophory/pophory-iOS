//
//  PhotoDetailViewController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

final class PhotoDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
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
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        view = photoDetailView
    }
}

// MARK: - navigation bar

extension PhotoDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 사진" }
}

extension PhotoDetailViewController {
    func setData(imageUrl: String, takenAt: String, studio: String, type: PhotoCellType) {
        self.image = imageUrl
        self.takenAt = takenAt
        self.studio = studio
        self.photoType = type
    }
}
