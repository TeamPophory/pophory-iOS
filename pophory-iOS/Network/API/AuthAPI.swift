//
//  AuthAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AuthAPI {
    case postAuthorizationCode(authorizationCode: String)
    case postIdentityToken(identityToken: String, socialType: String)
    case refreshToken(refreshToken: String)
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    
    var authToken: String? {
        switch self {
        case .postIdentityToken(let identityToken, _):
            return identityToken
        case .postAuthorizationCode, .withdrawUser:
            return PophoryTokenManager.shared.fetchAccessToken()
        case .refreshToken:
            return PophoryTokenManager.shared.fetchRefreshToken()
        }
    }
    
    var path: String {
        switch self {
        case .postAuthorizationCode, .postIdentityToken:
            return URLConstantsV2.auth
        case .withdrawUser:
            return URLConstants.auth
        case .refreshToken:
            return URLConstantsV2.auth + "/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAuthorizationCode, .postIdentityToken, .refreshToken:
            return .post
        case .withdrawUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postAuthorizationCode(let authorizationCode):
            return .requestParameters(parameters: ["authorizationCode": authorizationCode], encoding: JSONEncoding.default)
        case .postIdentityToken(_, let socialType):
            return .requestParameters(parameters: ["socialType": socialType], encoding: JSONEncoding.default)
        case .refreshToken:
            return .requestPlain
        case .withdrawUser:
            return .requestPlain
        }
    }
}
