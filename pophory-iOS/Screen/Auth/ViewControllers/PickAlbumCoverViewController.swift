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
    
    private let networkManager: AuthNetworkManagerProtocol
    
    private var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickname: String?
    
    private var selectedAlbumCoverIndex: Int = 1
    
    // MARK: - UI Properties
    
    private lazy var pickAlbumCoverView = PickAlbumCoverView()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickname: String?, pickAlbumCoverView: PickAlbumCoverView? = nil, nibName: String?, bundle: Bundle?, networkManager: AuthNetworkManagerProtocol) {
        self.fullName = fullName
        self.nickname = nickname
        self.networkManager = networkManager
        
        super.init(nibName: nibName, bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
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
    
    func OnClickBaseNextButton() {
        if let fullName = fullName, let nickName = nickname {
            let selectedIndex = selectedAlbumCoverIndex
            let signUpDTO = FetchSignUpRequestDTO(realName: fullName, nickname: nickName, albumCover: selectedIndex)
            processSignUp(dto: signUpDTO)
        }
    }
    
    func processSignUp(dto: FetchSignUpRequestDTO) {
        handleSignUpResult(dto: dto) { [weak self] in
            self?.moveToStartPophoryViewController()
        }
    }
}

// MARK: - Network

extension PickAlbumCoverViewController {
    private func handleSignUpResult(dto: FetchSignUpRequestDTO, completion: @escaping () -> Void) {
        networkManager.submitSignUp(dto: dto) { result in
            switch result {
            case .success(_):
                completion()
                // 추가 확인용 로그
                print("handleSignUpResult 클로저 실행됨")
            case .networkFail:
                print("Network failure")
            default:
                break
            }
        }
    }
}
