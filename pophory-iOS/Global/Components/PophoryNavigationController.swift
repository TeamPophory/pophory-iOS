//
//  PophoryNavigationController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

final class PophoryNavigationController: UINavigationController {

    override func viewDidLayoutSubviews() {
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureNavigationBar() {
        let titleFont = UIFont.head2
        let titleColor = UIColor.pophoryBlack
        lazy var defaultNaviBarHeight = { self.navigationBar.frame.size.height }()
        let newNaviBarHeight = defaultNaviBarHeight + 22
        
        var newFrame = self.navigationBar.frame
        newFrame.size.height = newNaviBarHeight
        navigationBar.frame = newFrame
        let titleAttributes: [NSAttributedString.Key: Any] = [.font: titleFont, .foregroundColor: titleColor]
        self.navigationBar.titleTextAttributes = titleAttributes

        navigationItem.title = navigationItem.title ?? "NavTitle"
    }
}
