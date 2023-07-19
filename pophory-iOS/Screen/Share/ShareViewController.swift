//
//  ShareViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class ShareViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let rootView = ShareView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
    }
}
