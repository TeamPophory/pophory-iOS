//
//  StartPophoryViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/03.
//

import UIKit

class StartPophoryViewController: BaseViewController {
    
    lazy var startPophoryView = StartPophoryView()
    
    override func loadView() {
        super.loadView()
        
        startPophoryView = StartPophoryView(frame: self.view.frame)
        self.view = startPophoryView
    }
    
    override func setupStyle() {
        view.backgroundColor = .pophoryPurple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        addButtonTarget()
    }
    
    private func addButtonTarget() {
        startPophoryView.startButton.addTarget(self, action: #selector(moveToTabBarViewController), for: .touchUpInside)
    }
    
    @objc
    private func moveToTabBarViewController() {
        let tabBarViewController = TabBarController()
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
}
