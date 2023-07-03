//
//  AddPhotoViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

final class AddPhotoViewController: BaseViewController, Navigatable {

    // MARK: - Properties
    
    var navigationBarTitleText: String? { return "사진 추가" }
    
    // MARK: - UI Properties
    
    private let rootView = AddPhotoView()
    
    // MARK: - Life Cycle - (init, life Cycle, deinit 순서)
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AddPhotoViewController {
    
    // MARK: - Layout
    
    // MARK: - @objc
    
    // MARK: - Private Methods
    
}

// MARK: - UITableView Delegate
