//
//  AuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AuthRepository {
    func sendAppleAuthorizationCode(code: String, completion: @escaping (NetworkResult<Any>) -> Void)
    func sendIdentityToken(identityToken: String, completion: @escaping (NetworkResult<Any>) -> Void)
    func checkDuplicateNickname(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void)
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void)
}
