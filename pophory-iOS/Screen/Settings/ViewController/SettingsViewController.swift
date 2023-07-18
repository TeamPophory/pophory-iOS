//
//  SettingsViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    // MARK: - UI Properties
    
    private let rootView = SettingsRootView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
        rootView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showNavigationBar()
    }
}

extension SettingsViewController {
    private func resetApp() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            return
        }
        
        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaults.standard.synchronize()
        
        presentRootVC()
    }
    
    private func logOut() {
        
        // TODO: 로그아웃 기능 구현
        
        presentRootVC()
    }
    
    private func presentRootVC() {
        let appleLoginManager = AppleLoginManager()
        let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
        let navVC = PophoryNavigationController(rootViewController: rootVC)
        
        appleLoginManager.delegate = rootVC
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
    }
}

// MARK: - navigation bar

extension SettingsViewController: Navigatable {
    var navigationBarTitleText: String? { "설정" }
}

// MARK: -

extension SettingsViewController: SettingsRootViewDelegate {
    func handleOnClickNotice() {
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/notice", title: "공지사항")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleOnClickPrivacyPolicy() {
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy2", title: "개인정보 처리방침")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleOnClickTerms() {
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy1", title: "이용약관")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleOnClickLogOut() {
                
        showPopup(popupType: .option,
                  primaryText: "로그아웃하실건가요?",
                  secondaryText: "다음에 꼭 다시보길 바라요",
                  firstButtonTitle: .logout,
                  secondButtonTitle: .back,
                  firstButtonHandler: logOut,
                  secondButtonHandler: {
            self.dismiss(animated: false)
        })
    }
    
    func handleOnClickDeleteAccount() {
                
        showPopup(popupType: .biasedOption,
                  primaryText: "정말 탈퇴하실 건가요?",
                  secondaryText: "지금 탈퇴하면 여러분의 앨범을 다시 찾을 수 없어요",
                  firstButtonTitle: .back,
                  secondButtonTitle: .deleteAccount,
                  secondButtonHandler: {
            NetworkService.shared.authRepostiory.withdraw { result in
                switch result {
                case .success(_):
                    self.resetApp()
                default:
                    break
                }
            }
        })
    }
}
