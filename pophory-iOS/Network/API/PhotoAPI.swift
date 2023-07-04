//
//  PhotoAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum PhotoAPI {
    case postPhoto(body: PostPhotoRequestDTO)
    case deletePhoto(photoId: Int)
}

extension PhotoAPI: BaseTargetType {
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
            return .requestJSONEncodable(body)
        case .deletePhoto:
            return .requestPlain
        }
    }
}
