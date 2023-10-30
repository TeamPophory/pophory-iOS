//
//  BaseViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/28.
//

import UIKit

// MARK: - BaseViewController

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: - Life Cycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStyle()
        setupLayout()
    }
    
    deinit {
        print("DEINIT: \(className)")
    }
    
    // MARK: - Layout
    
    /// Attributes (속성) 설정 메서드
    func setupStyle() {
        view.backgroundColor = .pophoryWhite
    }
    
    /// Hierarchy, Constraints (계층 및 제약조건) 설정 메서드
    func setupLayout() {}
        
    // MARK: - @objc
    
    @objc func backButtonOnClick() {
        guard let stackDepth = navigationController?.viewControllers.count else { return }
        
        let tabBarController = TabBarController()
        
        if self is PhotoDetailViewController {
            navigationController?.popViewController(animated: true)
        } else if stackDepth > 2 {
            navigationController?.setViewControllers([tabBarController], animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightButtonOnClick() {}

}
