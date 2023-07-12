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
        
        let appleLoginManager = AppleLoginManager()
        let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
        let navVC = UINavigationController(rootViewController: rootVC)
        navigationController?.pushViewController(navVC, animated: false)
    }
    
    private func logOut() {
        
        // TODO: 로그아웃 기능 구현
        
        let appleLoginManager = AppleLoginManager()
        let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
        let navVC = UINavigationController(rootViewController: rootVC)
        navigationController?.pushViewController(navVC, animated: false)
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
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/gaeinjeongbo-ceoribangcim/%E2%80%8B%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4-%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8", title: "개인정보 처리방침")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleOnClickTerms() {
        let vc = PophoryWebViewController(urlString: "https://pophoryofficial.wixsite.com/pophory/copy-of-gaeinjeongbo-ceoribangcim/%EC%84%9C%EB%B9%84%EC%8A%A4-%EC%9D%B4%EC%9A%A9-%EC%95%BD%EA%B4%80", title: "이용약관")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleOnClickLogOut() {
        
        // TODO: 포포리 커스텀 팝업뷰로 바꾸기
        
        let alert = UIAlertController(title: "로그아웃하실건가요?", message: "다음에 꼭 다시보길 바라요", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "로그아웃", style: .default, handler: { _ in
            self.logOut()
        }))

        present(alert, animated: true, completion: nil)
    }
    
    func handleOnClickDeleteAccount() {
        
        // TODO: 포포리 커스텀 팝업뷰로 바꾸기
        
        let alert = UIAlertController(title: "정말 탈퇴하실 건가요?", message: "지금 탈퇴하면 여러분의 앨범을 다시 찾을 수 없어요", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "돌아가기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "탈퇴하기", style: .destructive, handler: { _ in
            NetworkService.shared.authRepostiory.withdraw { result in
                switch result {
                case .success(_):
                    self.resetApp()
                default:
                    break
                }
            }
        }))

        present(alert, animated: true, completion: nil)
    }
    
}
