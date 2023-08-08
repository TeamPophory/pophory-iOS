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

final class PickAlbumCoverViewController: BaseViewController, PickAlbumCoverViewControllerDelegate {
    
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
        handleNextButton()
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
        self.pickAlbumCoverView.pickAlbumDelegate = self
    }
    
    func didEnterName(name: String) {
        fullName = name
    }
    
    //TODO: 함수명 변경
    func checkNicknameAndProceed(nickname: String, fullName: String) {
        self.nickname = nickname
        self.fullName = fullName
    }
    
    private func onClickNextButtonAsync() async {
        if let fullName = fullName, let nickname = nickname {
            let selectedIndex = selectedAlbumCoverIndex
            let signUpDTO = FetchSignUpRequestDTO(realName: fullName, nickname: nickname, albumCover: selectedIndex)
            await handleSignUpResult(dto: signUpDTO)
        }
    }
    
    private func handleNextButton() {
        let nextButtonAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.onClickNextButtonAsync()
            }
        }
        pickAlbumCoverView.nextButton.addAction(nextButtonAction, for: .touchUpInside)
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
    private func handleSignUpResult(dto: FetchSignUpRequestDTO) async {
        do {
            try await networkManager.requestSignUpProcess(dto: dto)
            DispatchQueue.main.async {
                self.moveToStartPophoryViewController()
            }
        } catch {
            DispatchQueue.main.async {
                self.presentErrorViewController(with: .serverError)
            }
        }
    }
}
