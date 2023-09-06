//
//  AuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AuthRepository {
    func submitAppleAuthorizationCode(code: String, completion: @escaping (NetworkResult<Any>) -> Void)
    func submitIdentityToken(tokenDTO: PostIdentityTokenDTO, completion: @escaping (NetworkResult<Any>) -> Void)
    func updateRefreshToken(completion: @escaping (NetworkResult<Any>) -> Void)
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void)
}
