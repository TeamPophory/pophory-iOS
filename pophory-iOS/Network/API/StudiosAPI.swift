//
//  StudiosAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum StudiosAPI {
    case patchStudios
}

extension StudiosAPI: BaseTargetType {
    var authToken: String? {
        // TODO: 자동로그인
        return UserDefaults.standard.string(forKey: "YOUR_USER_TOKEN_KEY")
    }
    
    var path: String {
        switch self {
        case .patchStudios:
            return URLConstants.studio
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchStudios:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchStudios:
            return .requestPlain
        }
    }
}
