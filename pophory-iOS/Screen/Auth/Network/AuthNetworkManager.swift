//
//  AuthNetworkManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/29.
//

import Foundation

class AuthNetworkManager {
    
    private let memberRepository: MemberRepository = DefaultMemberRepository()
    
    func requestNicknameCheck(nickname: String) async throws -> Bool {
        return try await memberRepository.requestDuplicateNicknameCheck(nickname: nickname)
    }
    
    func requestSignUpProcess(dto: FetchSignUpRequestDTO) async throws {
        return try await memberRepository.submitSignUp(body: dto)
    }
}
 
