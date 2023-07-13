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
    case postIdentityToken(tokenDTO: postIdentityTokenDTO)
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    var authToken: String? {
        switch self {
        case .postIdentityToken(let tokenDTO):
            return tokenDTO.identityToken
                
        case .sendAuthorizationCode, .withdrawUser:
            return UserDefaults.standard.string(forKey: "YOUR_USER_TOKEN_KEY")
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
            return .requestParameters(parameters: ["authorizationCode" : authorizationCode], encoding: JSONEncoding.default)
        case .postIdentityToken(let tokenDTO):
            return .requestJSONEncodable(tokenDTO)
        case .withdrawUser:
            return .requestPlain
        }
    }
}
