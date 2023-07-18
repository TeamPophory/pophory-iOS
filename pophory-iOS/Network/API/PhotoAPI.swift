//
//  PhotoAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum PhotoAPI {
    case postPhoto(body: [MultipartFormData])
    case deletePhoto(photoId: Int)
}

extension PhotoAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var headers: [String: String]? {
        switch self {
        case .postPhoto:
            var header = [
                "Content-Type": "multipart/form-dat"
            ]
            if let token = authToken {
                header["Authorization"] = "Bearer \(token)"
            }
            return header
        case .deletePhoto:
            var header = [
                "Content-Type": "application/json"
            ]
            if let token = authToken {
                header["Authorization"] = "Bearer \(token)"
            }
            return header
        }
    }
    
    
    var path: String {
        switch self {
        case .postPhoto:
            return URLConstants.photo
        case .deletePhoto(let photoId):
            return URLConstants.photo + "/\(photoId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPhoto:
            return .post
        case .deletePhoto:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postPhoto(let body):
            return .uploadMultipart(body)
        case .deletePhoto:
            return .requestPlain
        }
    }
}
