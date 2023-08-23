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
    case signUp(body: FetchSignUpRequestDTO)
    case patchUserInfo
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
        case .patchUserInfo:
            return URLConstants.memeber + "/me"
        case .fetchMyPageV2, .signUp, .checkDuplicateNickname:
            return URLConstantsV2.memeber
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMyPage, .fetchMyPageV2, .patchUserInfo:
            return .get
        case .signUp:
            return .patch
        case .checkDuplicateNickname:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMyPage, .fetchMyPageV2, .patchUserInfo:
            return .requestPlain
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .checkDuplicateNickname(let nickname):
            let parameters: [String: Any] = ["nickname": nickname]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
