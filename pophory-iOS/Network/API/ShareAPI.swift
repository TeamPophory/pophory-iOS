//
//  ShareAPI.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

import Moya

enum ShareAPI {
    case fetchSharePhoto(shareID: String)
    case postSharePhoto(photoID: Int)
}

extension ShareAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchSharePhoto(let shareID):
            return URLConstantsV2.share + "/\(shareID)"
        case .postSharePhoto(let photoID):
            return URLConstantsV2.share + "/photo/\(photoID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchSharePhoto:
            return .get
        case .postSharePhoto:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchSharePhoto, .postSharePhoto:
            return .requestPlain
        }
    }
}
