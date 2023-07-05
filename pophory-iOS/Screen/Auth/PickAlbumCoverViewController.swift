//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

protocol PickAlbumCoverViewControllerDelegate: AnyObject {
    func didSelectButton(at index: Int)
}

typealias SignUpDelegates = NameInputViewControllerDelegate & IDInputViewControllerDelegate

final class PickAlbumCoverViewController: BaseViewController, Navigatable, SignUpDelegates, PickAlbumCoverViewControllerDelegate {
    
    // MARK: - Properties
    
    var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickName: String?
    
    let memberRepository: MemberRepository = DefaultMemberRepository()
    
    // MARK: - UI Properties
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    lazy var pickAlbumCoverView: PickAlbumCoverView = {
        let view = PickAlbumCoverView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickName: String?, pickAlbumCoverView: PickAlbumCoverView? = nil, nibName: String?, bundle: Bundle?) {
        self.fullName = fullName
        self.nickName = nickName
        
        super.init(nibName: nibName, bundle: bundle)
        
        if let pickAlbumCoverView = pickAlbumCoverView {
            self.pickAlbumCoverView = pickAlbumCoverView
        } else {
            let view = PickAlbumCoverView()
            self.pickAlbumCoverView = view
            self.pickAlbumCoverView.delegate = self
        }
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
        self.pickAlbumCoverView.delegate = self
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
        
        if let fullName = fullName, let nickName = nickName {
            let signUpDTO = PatchSignUpRequestDTO(realName: fullName, nickname: nickName, albumCover: index)
            memberRepository.patchSignUp(body: signUpDTO) { result in
                switch result {
                case .success(_):
                    print("Successful signUp")
                case .requestErr(let data):
                    print("Request error: \(data)")
                case .pathErr:
                    print("Path error")
                case .serverErr:
                    print("Server error")
                case .networkFail:
                    print("Network failure") 
                }
            }
        }
    }
}
