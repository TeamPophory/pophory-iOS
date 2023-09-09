//
//  AlbumAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AlbumAPI {
    case fetchAlbumList
    case fetchAlbumPhotoList(albumId: Int)
    case patchAlbumCover(albumId: Int, body: patchAlbumCoverRequestDTO)
}

extension AlbumAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .fetchAlbumList:
            return URLConstantsV2.album
        case .fetchAlbumPhotoList(let albumId):
            return URLConstantsV2.album + "/\(albumId)/photo"
        case .patchAlbumCover(let albumId, _):
            return URLConstantsV2.album + "/\(albumId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAlbumList, .fetchAlbumPhotoList:
            return .get
        case .patchAlbumCover:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchAlbumList, .fetchAlbumPhotoList:
            return .requestPlain
        case .patchAlbumCover(_, let body):
            return .requestJSONEncodable(body)
        }
    }
}
