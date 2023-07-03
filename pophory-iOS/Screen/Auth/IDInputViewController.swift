//
//  IDInputViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

final class IDInputViewController: BaseViewController {
    
    lazy var iDInputView: IDInputView = {
        let view = IDInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        iDInputView = IDInputView(frame: self.view.frame)
        self.view = iDInputView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    
}
