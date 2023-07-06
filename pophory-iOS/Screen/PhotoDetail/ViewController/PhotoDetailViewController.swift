//
//  PhotoDetailViewController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

final class PhotoDetailViewController: BaseViewController {

    // MARK: - UI Properties
    
    private let photoDetailView = PhotoDetailView(frame: .zero,
                                                            takenAt: "2023.07.06",
                                                            studio: "인생네컷")
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = photoDetailView
        
    }
}

// MARK: - navigation bar

extension PhotoDetailViewController: Navigatable {
    var navigationBarTitleText: String? { return "내 사진" }
}
