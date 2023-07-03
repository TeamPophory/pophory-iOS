//
//  StartPophoryViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

class StartPophoryViewController: BaseViewController {
    
    lazy var startPophoryView: StartPophoryView = {
        let view = StartPophoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        startPophoryView = StartPophoryView(frame: self.view.frame)
        self.view = startPophoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
