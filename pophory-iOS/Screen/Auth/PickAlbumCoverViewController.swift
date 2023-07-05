//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

final class PickAlbumCoverViewController: BaseViewController, Navigatable {
    
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    lazy var pickAlbumCoverView: PickAlbumCoverView = {
        let view = PickAlbumCoverView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        pickAlbumCoverView = PickAlbumCoverView(frame: self.view.frame)
        self.view = pickAlbumCoverView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
