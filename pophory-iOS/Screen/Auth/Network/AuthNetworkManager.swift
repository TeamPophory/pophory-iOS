//
//  AuthNetworkManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/29.
//

import Foundation

class AuthNetworkManager {
    
    private let memberRepository: MemberRepository = DefaultMemberRepository()
    
    func submitSignUp(dto: FetchSignUpRequestDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.memberRepository.fetchSignUp(body: dto) { result in
                switch result {
                case .success(_):
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
