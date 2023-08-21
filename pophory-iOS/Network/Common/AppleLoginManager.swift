//
//  AppleLoginManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/07.
//

import AuthenticationServices

protocol AppleLoginManagerDelegate: AnyObject {
    func appleLoginManager(didCompleteWithAuthResult result: Result<ASAuthorization, Error>)
}

final class AppleLoginManager: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    weak var viewController: UIViewController?
    weak var delegate: AppleLoginManagerDelegate?
    
    func setAppleLoginPresentationAnchorView(_ view: UIViewController) {
        self.viewController = view
    }
    
    @objc func handleAppleLoginButtonClicked() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = []
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        delegate?.appleLoginManager(didCompleteWithAuthResult: .success(authorization))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.appleLoginManager(didCompleteWithAuthResult: .failure(error))
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController?.view.window ?? UIWindow()
    }
}
