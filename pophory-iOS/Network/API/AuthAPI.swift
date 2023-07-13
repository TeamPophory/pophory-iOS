//
//  AuthAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AuthAPI {
    case appleLogin(authorizationCode: String)
    case sendIdentityToken(identityToken: String)
    case checkDuplicateNickname(nickname: String)
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    var path: String {
        switch self {
        case .appleLogin, .sendIdentityToken, .withdrawUser:
            return URLConstants.auth
        case .checkDuplicateNickname:
            return URLConstants.memeber
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .appleLogin, .sendIdentityToken, .checkDuplicateNickname:
            return .post
        case .withdrawUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .appleLogin(let authorizationCode):
            return .requestParameters(parameters: ["authorizationCode" : authorizationCode], encoding: JSONEncoding.default)
        case .sendIdentityToken(let identityToken):
            return .requestParameters(parameters: ["identityToken": identityToken], encoding: JSONEncoding.default)
        case .checkDuplicateNickname(let nickname):
            let parameters: [String: Any] = ["nickname": nickname]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .withdrawUser:
            return .requestPlain
        }
    }
}
