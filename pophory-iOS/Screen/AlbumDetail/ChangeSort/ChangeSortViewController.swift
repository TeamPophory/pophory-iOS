//
//  ChangeSortViewController.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import UIKit

import SnapKit

final class ChangeSortViewController: BaseViewController {
    
    let changeSortView = ChangeSortView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        view = changeSortView
    }
}
