//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

typealias SignUpDelegates = NameInputViewControllerDelegate & IDInputViewControllerDelegate

final class PickAlbumCoverViewController: BaseViewController, Navigatable, SignUpDelegates {
    
    // MARK: - Properties
    
    var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickName: String?
    
    // MARK: - UI Properties
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    lazy var pickAlbumCoverView: PickAlbumCoverView = {
        let view = PickAlbumCoverView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickName: String?, pickAlbumCoverView: PickAlbumCoverView, nibName: String?, bundle: Bundle?) {
        self.fullName = fullName
        self.nickName = nickName
        self.pickAlbumCoverView = pickAlbumCoverView
        super.init(nibName: nibName, bundle: bundle)

        self.pickAlbumCoverView.delegate = self
    }

    
    override func loadView() {
        super.loadView()
        
        pickAlbumCoverView = PickAlbumCoverView(frame: self.view.frame)
        self.view = pickAlbumCoverView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK: - Extensions

extension PickAlbumCoverViewController {

    func didEnterName(name: String) {
        fullName = name
        print("Full name: \(fullName ?? "None")🅾️")
    }
    
    func didEnterNickname(nickname: String, fullName: String) {
        self.nickName = nickname
        self.fullName = fullName
        print("Nickname: \(nickname), Full name: \(fullName)🩷")
    }
}

extension PickAlbumCoverViewController: PickAlbumCoverViewDelegate {
    
    func didSelectButton(at index: Int) {
        print("Selected item at index: \(index)")
    }
}

