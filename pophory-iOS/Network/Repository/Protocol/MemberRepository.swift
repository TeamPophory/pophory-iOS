//
//  MemberRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol MemberRepository {
    func fetchMyPage(version: Int, completion: @escaping (NetworkResult<FetchMyPageResponseDTO>) -> Void)
    func submitSignUp(body: FetchSignUpRequestDTO, completion: @escaping (NetworkResult<Void>) -> Void)
    func fetchUserInfo(completion: @escaping (NetworkResult<FetchUserInfoResponseDTO>) -> Void)
    func requestDuplicateNicknameCheck(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void)
}
