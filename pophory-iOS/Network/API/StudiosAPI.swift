//
//  StudiosAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum StudiosAPI {
    case fetchStudios
}

extension StudiosAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchStudios:
            return URLConstants.studio
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchStudios:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchStudios:
            return .requestPlain
        }
    }
}
