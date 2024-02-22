//
//  AuthNetworkManager.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/29.
//

import Foundation

class AuthNetworkManager {
    
    func requestNicknameCheck(nickname: String) async throws -> Bool {
        return try await NetworkService.shared.memberRepository.requestDuplicateNicknameCheck(nickname: nickname)
    }
    
    func requestSignUpProcess(dto: patchSignUpRequestDTO) async throws {
        return try await NetworkService.shared.memberRepository.submitSignUp(body: dto)
    }
}
 
