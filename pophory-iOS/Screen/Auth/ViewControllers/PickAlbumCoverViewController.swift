//
//  PickAlbumCoverViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

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
    
    private lazy var pickAlbumCoverView = PickAlbumCoverView()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickname: String?, pickAlbumCoverView: PickAlbumCoverView? = nil, nibName: String?, bundle: Bundle?) {
        self.fullName = fullName
        self.nickname = nickname
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(pickAlbumCoverView)
        
        pickAlbumCoverView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
    }
    
    @objc private func moveToStartPophoryViewController() {
        let nextVC = StartPophoryViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Extensions

extension PickAlbumCoverViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}

extension PickAlbumCoverViewController {
    
    private func setupDelegate() {
        self.pickAlbumCoverView.delegate = self
        self.pickAlbumCoverView.pickAlbumDelegate = self
    }
    
    func didEnterName(name: String) {
        fullName = name
    }
    
    func didEnterNickname(nickname: String, fullName: String) {
        self.nickname = nickname
        self.fullName = fullName
    }
}

// MARK: - PickAlbumCoverViewDelegate

extension PickAlbumCoverViewController: PickAlbumCoverViewDelegate {
    
    func didSelectAlbumButton(at index: Int) {
        selectedAlbumCoverIndex = index
    }
    
    func didTapBaseNextButton() {
        if let fullName = fullName, let nickName = nickname {
            let selectedIndex = selectedAlbumCoverIndex
            let signUpDTO = FetchSignUpRequestDTO(realName: fullName, nickname: nickName, albumCover: selectedIndex)
            submitSignUP(dto: signUpDTO)
        }
    }
}

// MARK: - Network

extension PickAlbumCoverViewController {
    
    private func submitSignUP(dto: FetchSignUpRequestDTO) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.memberRepository.fetchSignUp(body: dto) { result in
                switch result {
                case .success(_):
                    print("Successful signUp")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    DispatchQueue.main.async {
                        self?.moveToStartPophoryViewController()
                    }
                case .requestErr(let data):
                    print("Request error: \(data)")
                case .pathErr:
                    print("Path error")
                case .serverErr:
                    print("Server error")
                case .networkFail:
                    print("Network failure")
                default:
                    break
                }
            }
        }
    }
}
