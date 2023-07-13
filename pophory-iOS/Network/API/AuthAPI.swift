//
//  AuthAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AuthAPI {
    case sendAuthorizationCode(authorizationCode: String)
    case sendIdentityToken(identityToken: String, socialType: String)
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    
    var authToken: String? {
        switch self {
        case .sendIdentityToken(let identityToken, _):
            return identityToken
            
        case .sendAuthorizationCode, .withdrawUser:
            return UserDefaults.standard.string(forKey: "YOUR_USER_TOKEN_KEY")
        }
    }
    
    var path: String {
        switch self {
        case .sendAuthorizationCode, .sendIdentityToken, .withdrawUser:
            return URLConstants.auth
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendAuthorizationCode, .sendIdentityToken:
            return .post
        case .withdrawUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendAuthorizationCode(let authorizationCode):
            return .requestParameters(parameters: ["authorizationCode" : authorizationCode], encoding: JSONEncoding.default)
        case .sendIdentityToken(let identityToken, let socialType):
                   return .requestParameters(parameters: ["identityToken": identityToken, "socialType": socialType], encoding: JSONEncoding.default)
        case .withdrawUser:
            return .requestPlain
        }
    }
}
