//
//  BaseViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/28.
//

import UIKit

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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
    }
    
    deinit {
        print("DEINIT: \(className)")
    }
}

extension BaseViewController {
    // MARK: - Layout
    
    /// Attributes (속성) 설정 메서드
    func setStyle() {
        view.backgroundColor = .white
    }
    
    /// Hierarchy, Constraints (계층 및 제약조건) 설정 메서드
    func setLayout() {}
}
