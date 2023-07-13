//
//  PophoryNavigationController.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/07/06.
//

import UIKit

//protocol NavigationConfigurator {
//    func configureNavigationBar(in viewController: UIViewController, navigationController: UINavigationController)
//    func configureRightButton(in viewController: UIViewController, navigationController: UINavigationController, showRightButton: Bool)
//}

class PophoryNavigationController: UINavigationController {

    override func viewDidLayoutSubviews() {
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureNavigationBar() {
        let titleFont = UIFont.head2
        let titleColor = UIColor.pophoryBlack
        let titleText: String?
        lazy var defaultNaviBarHeight = { self.navigationBar.frame.size.height }()
        let newNaviBarHeight = defaultNaviBarHeight + 22
        
        var newFrame = self.navigationBar.frame
        newFrame.size.height = newNaviBarHeight
        navigationBar.frame = newFrame
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        self.navigationBar.titleTextAttributes = titleAttributes

        navigationItem.title = navigationItem.title ?? "NavTitle"
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(BaseViewController.backButtonOnClick))
        backButton.tintColor = UIColor.white
        //TODO: 에셋 추가 후 등록예정
//        navigationBar.backIndicatorImage = UIImage(named: "")
//        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "")
//        navigationItem.backBarButtonItem = backButton
        
    }
}
