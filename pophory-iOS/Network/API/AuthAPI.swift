//
//  AuthAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AuthAPI {
    case withdrawUser
}

extension AuthAPI: BaseTargetType {
    var path: String {
        switch self {
        case .withdrawUser:
            return URLConstants.auth
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .withdrawUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .withdrawUser:
            return .requestPlain
        }
    }
}
