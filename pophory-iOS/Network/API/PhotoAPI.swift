//
//  PhotoAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum PhotoAPI {
    case fetchAllPhotos
    case fetchPresignedPhotoURL
    case postPhoto(body: PostPhotoS3RequestDTO)
    case deletePhoto(photoId: Int)
}

extension PhotoAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchAllPhotos:
            return URLConstantsV2.photo
        case .fetchPresignedPhotoURL:
            return URLConstantsV2.v3 + "/photo"
        case .postPhoto:
            return URLConstantsV2.photo
        case .deletePhoto(let photoId):
            return URLConstants.photo + "/\(photoId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPresignedPhotoURL, .fetchAllPhotos:
            return .get
        case .postPhoto:
            return .post
        case .deletePhoto:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchPresignedPhotoURL, .fetchAllPhotos:
            return .requestPlain
        case .postPhoto(let body):
            return .requestJSONEncodable(body)
        case .deletePhoto:
            return .requestPlain
        }
    }
}
