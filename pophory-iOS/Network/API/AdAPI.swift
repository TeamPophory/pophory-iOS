//
//  AdAPI.swift
//  pophory-iOS
//
//  Created by 강윤서 on 10/31/23.
//

import Foundation

import Moya

enum AdAPI {
    case fetchAdInfo(os: String, version: String)
}

extension AdAPI: BaseTargetType {
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchAdInfo:
            return URLConstantsV2.ad
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAdInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAdInfo(let os, let version):
            return .requestParameters(
                parameters: ["os": os, "version": version],
                encoding: URLEncoding.queryString)
        }
    }
}
