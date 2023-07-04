//
//  MemberAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum MemberAPI {
    case patchMyPage
    case signUp(body: PatchSignUpRequestDTO)
    case patchUserInfo
}

extension MemberAPI: BaseTargetType {
    var path: String {
        switch self {
        case .patchMyPage, .signUp:
            return URLConstants.memeber
        case .patchUserInfo:
            return URLConstants.memeber + "/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchMyPage, .patchUserInfo:
            return .get
        case .signUp:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchMyPage, .patchUserInfo:
            return .requestPlain
        case .signUp(let body):
            return .requestJSONEncodable(body)
        }
    }
}
