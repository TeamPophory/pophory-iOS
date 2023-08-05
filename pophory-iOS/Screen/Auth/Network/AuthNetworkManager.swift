//
//  AuthNetworkManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/29.
//

import Foundation

class AuthNetworkManager {
    
    private let memberRepository: MemberRepository = DefaultMemberRepository()
    
    func requestNicknameCheck(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.memberRepository.requestDuplicateNicknameCheck(nickname: nickname) { result in
                completion(result)
            }
        }
    }
    
    func requestSignUpProcess(dto: FetchSignUpRequestDTO, completion: @escaping (NetworkResult<Void>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.memberRepository.submitSignUp(body: dto) { result in
                completion(result)
            }
        }
    }
}
