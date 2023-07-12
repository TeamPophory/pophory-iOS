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
        return
    }
    
    func handleOnClickDeleteAccount() {
        return
    }
    
}
