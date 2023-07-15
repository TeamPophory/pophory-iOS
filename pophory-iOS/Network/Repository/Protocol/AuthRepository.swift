//
//  AuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AuthRepository {
    func sendAppleAuthorizationCode(code: String, completion: @escaping (NetworkResult<Any>) -> Void)
      func postIdentityToken(tokenDTO: PostIdentityTokenDTO, completion: @escaping (NetworkResult<Any>) -> Void)
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void)
}
