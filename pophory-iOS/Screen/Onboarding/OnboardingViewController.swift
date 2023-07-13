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
        
        hideNavigationBar()
        onboardingView.realAppleSignInButton.addTarget(self, action: #selector(handleAppleLoginButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    @available(iOS 13.0, *)
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
                    print("Identity Token: \(identityTokenString)"+"✈️")
                    sendIdentityTokenToServer(identityToken: identityTokenString)
                }
                
                print("Successful Apple login")
                goToSignInViewController()
            }
            
        case .failure(let error):
            print("Failed Apple login with error: \(error.localizedDescription)"+"🥹")
        }
    }
    
    private func sendIdentityTokenToServer(identityToken: String) {
        let tokenDTO = postIdentityTokenDTO(socialType: "APPLE", identityToken: identityToken)
        NetworkService.shared.authRepostiory.postIdentityToken(tokenDTO: tokenDTO) { result in
            
            switch result {
            case .success:
                print("Successfully sent Identity Token to server")
                self.saveTokenToInternalDatabase(token: identityToken)
            case .requestErr(let errorMessage):
                print("Error sending Identity Token to server: \(errorMessage)")
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
    
    private func saveTokenToInternalDatabase(token: String) {
        UserDefaults.standard.set(token, forKey: "socialLoginToken")
    }

    private func getTokenFromInternalDatabase() -> String? {
        return UserDefaults.standard.string(forKey: "socialLoginToken")
    }

    private func goToSignInViewController() {
        let nameInputVC = NameInputViewController()
        navigationController?.pushViewController(nameInputVC, animated: true)
    }
}
