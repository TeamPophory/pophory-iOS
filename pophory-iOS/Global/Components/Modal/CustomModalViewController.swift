//
//  CustomModalViewController.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/05.
//

import UIKit

class CustomModalViewController: UIViewController {
    
    let modalHeight: CGFloat = 300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dismissModal(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
