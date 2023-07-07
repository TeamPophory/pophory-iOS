//
//  SettingsViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let rootView = SettingsRootView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showNavigationBar()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
}

// MARK: - navigation bar

extension SettingsViewController: Navigatable {
    var navigationBarTitleText: String? { "설정" }
}
