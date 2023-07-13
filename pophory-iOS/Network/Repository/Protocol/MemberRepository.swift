//
//  MemberRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol MemberRepository {
    func patchMyPage(completion: @escaping (NetworkResult<PatchMyPageResponseDTO>) -> Void)
    func patchSignUp(
        body: PatchSignUpRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
    func patchUserInfo(completion: @escaping (NetworkResult<PatchUserInfoResponseDTO>) -> Void)
    func checkDuplicateNickname(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void)
}
