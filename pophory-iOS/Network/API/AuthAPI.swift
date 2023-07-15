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
    case postIdentityToken(identityToken: String, socialType: String)
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    
    var authToken: String? {
        switch self {
        case .postIdentityToken(let identityToken, _):
            return identityToken
        case .sendAuthorizationCode, .withdrawUser:
            return PophoryTokenManager.shared.fetchAccessToken()
        }
    }
    
    var path: String {
        switch self {
        case .sendAuthorizationCode, .postIdentityToken, .withdrawUser:
            return URLConstants.auth
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendAuthorizationCode, .postIdentityToken:
            return .post
        case .withdrawUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sendAuthorizationCode(let authorizationCode):
            return .requestParameters(parameters: ["authorizationCode": authorizationCode], encoding: JSONEncoding.default)
        case .postIdentityToken(_, let socialType):
            return .requestParameters(parameters: ["socialType": socialType], encoding: JSONEncoding.default)
        case .withdrawUser:
            return .requestPlain
        }
    }

}
