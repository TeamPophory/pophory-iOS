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

final class PickAlbumCoverViewController: BaseViewController, SignUpDelegates, PickAlbumCoverViewControllerDelegate {
    
    // MARK: - Properties
    
    private var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickname: String?
    
    private var selectedAlbumCoverIndex: Int = 1
    
    private let memberRepository: MemberRepository = DefaultMemberRepository()
    
    // MARK: - UI Properties
    
    private lazy var pickAlbumCoverView: PickAlbumCoverView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    private func addButtonTarget() {
        self.pickAlbumCoverView.nextButton.addTarget(self, action: #selector(moveToStartPophoryViewController), for: .touchUpInside)
    }
    
    @objc
    private func moveToStartPophoryViewController() {
        let nextVC = StartPophoryViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
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

extension PickAlbumCoverViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}


extension PickAlbumCoverViewController: PickAlbumCoverViewDelegate {
    
    func didSelectAlbumButton(at index: Int) {
        selectedAlbumCoverIndex = index + 1
        print(selectedAlbumCoverIndex)
    }
    
    func didTapBaseNextButton() {
        if let fullName = fullName, let nickName = nickname {
            let selectedIndex = selectedAlbumCoverIndex
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
