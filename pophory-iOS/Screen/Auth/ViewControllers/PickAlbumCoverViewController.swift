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

final class PickAlbumCoverViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let networkManager: AuthNetworkManager
    
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
        pickAlbumCoverView.delegate = self
        pickAlbumCoverView.pickAlbumDelegate = self
    }
}

// MARK: - NextButtonDelegate

extension PickAlbumCoverViewController: NextButtonDelegate {
    func onClickNextButton() {
        guard let fullName = fullName,
              let nickname = nickname else { return }
        
        let signUpDTO = FetchSignUpRequestDTO(realName: fullName, nickname: nickname, albumCover: selectedAlbumCoverIndex)
        
        Task {
            let signUpResult = await handleSignUpResult(dto: signUpDTO)
            
            if signUpResult {
                self.moveToStartPophoryViewController()
            } else {
                self.presentErrorViewController(with: .networkError)
            }
        }
    }
}

// MARK: - PickAlbumCoverViewDelegate

extension PickAlbumCoverViewController: PickAlbumCoverViewDelegate {
    func didSelectAlbumButton(at index: Int) {
        selectedAlbumCoverIndex = index
    }
    
    func moveToStartPophoryViewController() {
        let nextVC = StartPophoryViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Network

extension PickAlbumCoverViewController {
    private func handleSignUpResult(dto: FetchSignUpRequestDTO) async -> Bool{
        do {
            try await networkManager.requestSignUpProcess(dto: dto)
            return true
        } catch {
            return false
        }
    }
}
