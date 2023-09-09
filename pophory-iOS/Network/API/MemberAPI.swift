//
//  MemberAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum MemberAPI {
    case fetchMyPage
    case fetchMyPageV2
    case patchSignUp(body: patchSignUpRequestDTO)
    case fetchUserInfo
    case checkDuplicateNickname(nickname: String)
}

extension MemberAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchMyPage:
            return URLConstants.memeber
        case .fetchUserInfo:
            return URLConstants.memeber + "/me"
        case .fetchMyPageV2, .patchSignUp, .checkDuplicateNickname:
            return URLConstantsV2.memeber
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyPage, .fetchMyPageV2, .fetchUserInfo:
            return .get
        case .patchSignUp:
            return .patch
        case .checkDuplicateNickname:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMyPage, .fetchMyPageV2, .fetchUserInfo:
            return .requestPlain
        case .patchSignUp(let body):
            return .requestJSONEncodable(body)
        case .checkDuplicateNickname(let nickname):
            let parameters: [String: Any] = ["nickname": nickname]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
