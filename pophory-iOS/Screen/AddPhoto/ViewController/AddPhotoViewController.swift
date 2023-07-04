//
//  AddPhotoViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

final class AddPhotoViewController: BaseViewController, Navigatable {

    // MARK: - Properties
    
    var navigationBarTitleText: String? { return "사진 추가" }
    
    // MARK: - UI Properties
    
    private let rootView = AddPhotoView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTarget()
    }

}

extension AddPhotoViewController {
        
    // MARK: - @objc
    
    @objc func onclickDateButton() {
        print("날짜")
    }
    
    @objc func onclicStudioButton() {
        print("사진관")
    }
    
    @objc func onclickFriendsButton() {
        print("친구")
    }

    // MARK: - Private Methods
    
    private func setupTarget() {
        rootView.dateStackView.infoButton.addTarget(self, action: #selector(onclickDateButton), for: .touchUpInside)
        rootView.studioStackView.infoButton.addTarget(self, action: #selector(onclicStudioButton), for: .touchUpInside)
        rootView.friendsStackView.infoButton.addTarget(self, action: #selector(onclickFriendsButton), for: .touchUpInside)
    }
    
}

// MARK: - UITableView Delegate
