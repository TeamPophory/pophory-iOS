//
//  MemberRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol MemberRepository {
    func fetchMyPage(version: Int, completion: @escaping (NetworkResult<FetchMyPageResponseDTO>) -> Void)
    func fetchSignUp(
        body: FetchSignUpRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
    func fetchUserInfo(completion: @escaping (NetworkResult<FetchUserInfoResponseDTO>) -> Void)
    func checkDuplicateNickname(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void)
}
