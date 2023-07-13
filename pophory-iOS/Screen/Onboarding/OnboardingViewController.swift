//
//  OnboardingViewController.swift
//  ZKFace
//
//  Created by Joon Baek on 2023/06/27.
//

import AuthenticationServices
import UIKit

final class OnboardingViewController: BaseViewController, AppleLoginManagerDelegate {
    
    lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let appleLoginManager: AppleLoginManager
    
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
    
    @available(iOS 13.0, *)
    @objc private func handleAppleLoginButtonClicked() {
        appleLoginManager.setAppleLoginPresentationAnchorView(self)
        appleLoginManager.handleAppleLoginButtonClicked()
    }
    
    func appleLoginManager(didCompleteWithAuthResult result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let email = appleIDCredential.email
                if let authorizationCode = appleIDCredential.authorizationCode, let authCodeString = String(data: authorizationCode, encoding: .utf8) {
                    print("Authorization Code: \(authCodeString)")
                    sendAuthorizationCodeToServer(authorizationCode: authCodeString)
                }
                
                print("Successful Apple login")
                goToSignInViewController()
            }
            
        case .failure(let error):
            print("Failed Apple login with error: \(error.localizedDescription)")
        }
    }
    
    // 클라이언트에서 백엔드 서버로 Authorization Code 전송
    func sendAuthorizationCodeToServer(authorizationCode: String) {
        guard let url = URL(string: "https://your-backend-server.com/apple-auth") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = ["authorizationCode": authorizationCode]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)

        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error sending Authorization Code to server: \(error.localizedDescription)")
            } else {
                print("Successfully sent Authorization Code to server")
            }
        }.resume()
    }
    
    func goToSignInViewController() {
        let nameInputVC = NameInputViewController()
        navigationController?.pushViewController(nameInputVC, animated: true)
    }
}
