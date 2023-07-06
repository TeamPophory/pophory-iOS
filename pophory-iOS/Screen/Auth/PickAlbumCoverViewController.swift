//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

protocol PickAlbumCoverViewControllerDelegate: AnyObject {
    func didSelectAlbumButton(at index: Int)
}

typealias SignUpDelegates = NameInputViewControllerDelegate & IDInputViewControllerDelegate

final class PickAlbumCoverViewController: BaseViewController, Navigatable, SignUpDelegates, PickAlbumCoverViewControllerDelegate {
    
    // MARK: - Properties
    
    var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickname: String?
    private var selectedAlbumCoverIndex: Int?
    
    let memberRepository: MemberRepository = DefaultMemberRepository()
    
    // MARK: - UI Properties
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    lazy var pickAlbumCoverView: PickAlbumCoverView = {
        let view = PickAlbumCoverView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickname: String?, pickAlbumCoverView: PickAlbumCoverView? = nil, nibName: String?, bundle: Bundle?) {
        self.fullName = fullName
        self.nickname = nickname
        
        super.init(nibName: nibName, bundle: bundle)
        
        if let pickAlbumCoverView = pickAlbumCoverView {
            self.pickAlbumCoverView = pickAlbumCoverView
        } else {
            let view = PickAlbumCoverView()
            self.pickAlbumCoverView = view
        }
    }
    
    override func loadView() {
        super.loadView()
        
        pickAlbumCoverView = PickAlbumCoverView(frame: self.view.frame)
        pickAlbumCoverView.delegate = self
        self.view = pickAlbumCoverView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
}

// MARK: - Extensions

extension PickAlbumCoverViewController {
    
    func didEnterName(name: String) {
        fullName = name
    }
    
    func didEnterNickname(nickname: String, fullName: String) {
        self.nickname = nickname
        self.fullName = fullName
    }
}

extension PickAlbumCoverViewController: PickAlbumCoverViewDelegate {
    
    func didSelectAlbumButton(at index: Int) {
        selectedAlbumCoverIndex = index
        print(index)
    }
    
    func didTapBaseNextButton() {
        if let fullName = fullName, let nickName = nickname, let selectedIndex = selectedAlbumCoverIndex {
            let signUpDTO = PatchSignUpRequestDTO(realName: fullName, nickname: nickName, albumCover: selectedIndex)
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
