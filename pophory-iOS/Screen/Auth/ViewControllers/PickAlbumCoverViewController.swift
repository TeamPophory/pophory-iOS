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
    
    private let networkManager: AuthNetworkManager
    
    private var delegate: SignUpDelegates?
    
    var fullName: String?
    var nickname: String?
    
    private var selectedAlbumCoverIndex: Int = 1
    
    // MARK: - UI Properties
    
    private lazy var pickAlbumCoverView = PickAlbumCoverView()
    
    // MARK: - Life Cycle
    
    init(fullName: String?, nickname: String?, pickAlbumCoverView: PickAlbumCoverView? = nil, networkManager: AuthNetworkManager = AuthNetworkManager()) {
        self.fullName = fullName
        self.nickname = nickname
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
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
        
        setupViewConstraints(pickAlbumCoverView)
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
        if let fullName = fullName, let nickname = nickname {
            let selectedIndex = selectedAlbumCoverIndex
            let signUpDTO = FetchSignUpRequestDTO(realName: fullName, nickname: nickname, albumCover: selectedIndex)
            handleSignUpResult(dto: signUpDTO)
        }
    }
    
    func moveToStartPophoryViewController() {
        let nextVC = StartPophoryViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Network

extension PickAlbumCoverViewController {
    private func handleSignUpResult(dto: FetchSignUpRequestDTO) {
        networkManager.requestSignUpProcess(dto: dto) { [weak self] result in
            switch result {
            case .success(_):
                self?.moveToStartPophoryViewController()
            case .networkFail:
                self?.presentErrorViewController(with: .networkError)
            default:
                break
            }
        }
    }
}
