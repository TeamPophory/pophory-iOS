//
//  AuthNetworkManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/29.
//

import Foundation

protocol AuthNetworkManagerProtocol {
    func submitSignUp(dto: FetchSignUpRequestDTO, completion: @escaping(NetworkResult<Void>) -> Void)
}

class AuthNetworkManager: AuthNetworkManagerProtocol {
    
    private let memberRepository: MemberRepository = DefaultMemberRepository()
    
    func submitSignUp(dto: FetchSignUpRequestDTO, completion: @escaping (NetworkResult<Void>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.memberRepository.fetchSignUp(body: dto) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        print("Successful signUp")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        completion(.success(()))
                    case .networkFail:
                        print("Network failure")
                    default:
                        break
                    }
                }
            }
        }
    }
}
