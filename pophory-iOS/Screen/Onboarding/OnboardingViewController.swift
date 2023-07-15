//
//  OnboardingViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import AuthenticationServices

import UIKit

final class OnboardingViewController: BaseViewController, AppleLoginManagerDelegate {
    
    // MARK: - Properties
    
    lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let appleLoginManager: AppleLoginManager
    
    let userDefaultsAccessTokenKey = "accessToken"
    let userDefaultsRefreshTokenKey = "refreshToken"
    
    // MARK: - Life Cycle
    
    init(appleLoginManager: AppleLoginManager) {
        self.appleLoginManager = appleLoginManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        onboardingView = OnboardingView(frame: self.view.frame)
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAccessToken()
        onboardingView.realAppleSignInButton.addTarget(self, action: #selector(handleAppleLoginButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func setupAppleSignInButton() {
        onboardingView.realAppleSignInButton.addTarget(self, action: #selector(handleAppleLoginButtonClicked), for: .touchUpInside)
    }
    
    @objc private func handleAppleLoginButtonClicked() {
        appleLoginManager.setAppleLoginPresentationAnchorView(self)
        appleLoginManager.handleAppleLoginButtonClicked()
    }
    
    func appleLoginManager(didCompleteWithAuthResult result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                if let identityTokenData = appleIDCredential.identityToken,
                   let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                    print("Identity Token: \(identityTokenString)")
                    submitIdentityTokenToServer(identityToken: identityTokenString)
                }
                
                print("Successful Apple login")
                goToSignInViewController()
            }
            
        case .failure(let error):
            print("Failed Apple login with error: \(error.localizedDescription)")
        }
    }
    
    private func submitIdentityTokenToServer(identityToken: String) {
        let tokenDTO = PostIdentityTokenDTO(socialType: "APPLE", identityToken: identityToken)
        NetworkService.shared.authRepostiory.submitIdentityToken(tokenDTO: tokenDTO) { result in
            switch result {
            case .success(let response):
                if let loginResponse = response as? LoginAPIDTO {
                    print("Successfully sent Identity Token to server")
                    
                    PophoryTokenManager.shared.saveAccessToken(loginResponse.accessToken)
                                   PophoryTokenManager.shared.saveRefreshToken(loginResponse.refreshToken)
                } else {
                    print("Unexpected response")
                }
            case .requestErr(let message):
                print("Error sending Identity Token to server: \(message)")
            case .networkFail:
                print("Network error")
            case .serverErr, .pathErr:
                print("Server or Path error")
            }
        }
    }
    
    private func saveLoginStatus() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

    private func fetchAccessToken() {
        if let accessToken = UserDefaults.standard.string(forKey: userDefaultsAccessTokenKey) {
            print("Access Token: \(accessToken)")
        }
    }
    
    private func goToSignInViewController() {
        let nameInputVC = NameInputViewController()
        navigationController?.pushViewController(nameInputVC, animated: true)
    }
}
