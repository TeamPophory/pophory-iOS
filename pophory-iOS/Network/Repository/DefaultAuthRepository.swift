//
//  DefaultAuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultAuthRepository: BaseRepository, AuthRepository {
    
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
    
    func sendAppleAuthorizationCode(code: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.sendAuthorizationCode(authorizationCode: code)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(.success("Apple authorization code sent successfully."))
                } else {
                    completion(.requestErr("Failed to send Apple authorization code."))
                }
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    func sendIdentityToken(identityToken: String, socialType: String, completion: @escaping (NetworkResult<Any>) -> Void) {
           provider.request(.sendIdentityToken(identityToken: identityToken, socialType: socialType)) { result in
               switch result {
               case .success(let response):
                   if response.statusCode < 300 {
                       completion(.success("Identity Token sent successfully."))
                   } else {
                       completion(.requestErr("Failed to send Identity Token."))
                   }
               case .failure(let error):
                   print(error)
                   completion(.networkFail)
               }
           }
       }
    
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.withdrawUser) { result in
            switch result {
            case.success(_):
                completion(.success((Any).self))
            case .failure(let err):
                print(err)
            }
        }
    }
}
