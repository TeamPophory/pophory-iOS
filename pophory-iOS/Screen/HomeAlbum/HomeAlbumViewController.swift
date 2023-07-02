//
//  HomeAlbumViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

class HomeAlbumViewController: BaseViewController {
    
    let homeAlbumView = HomeAlbumView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupLayout() {
        view = homeAlbumView
    }
    
    override func setupStyle() {
        view.backgroundColor = .white
    }
}
