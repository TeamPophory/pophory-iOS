//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

class PickAlbumCoverViewController: BaseViewController, Navigatable {

    
    var navigationBarTitleText: String? { return "회원가입" }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
