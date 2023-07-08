//
//  MypageViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

class MypageViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let rootView = MyPageRootView()
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
}

extension MypageViewController {
    private func setupHandlers() {
        rootView.handleOnClickSetting(onClickSetting)
    }
    
    private func onClickSetting() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
