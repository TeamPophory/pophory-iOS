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

        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
    }
}

// MARK: - navigation bar

extension SettingsViewController: Navigatable {
    var navigationBarTitleText: String? { "설정" }
}
