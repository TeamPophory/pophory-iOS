//
//  UserNameViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

class NameInputViewController: BaseViewController, Navigatable {
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    lazy var nameInputView: NameInputView = {
        let view = NameInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        nameInputView = NameInputView(frame: self.view.frame)
        self.view = nameInputView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
