//
//  AlbumAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum AlbumAPI {
    case patchAlbumList
    case patchAlbumPhotoList(albumId: Int)
    case patchAlbumCover(albumId: Int, body: PatchAlbumCoverRequestDTO)
}

extension AlbumAPI: BaseTargetType {
    
    var authToken: String? {
        return PophoryTokenManager.shared.fetchAccessToken()
    }
    
    var path: String {
        switch self {
        case .patchAlbumList:
            return URLConstantsV2.album
        case .patchAlbumPhotoList(let albumId):
            return URLConstantsV2.album + "/\(albumId)/photo"
        case .patchAlbumCover(let albumId, _):
            return URLConstantsV2.album + "/\(albumId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchAlbumList, .patchAlbumPhotoList:
            return .get
        case .patchAlbumCover:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchAlbumList, .patchAlbumPhotoList:
            return .requestPlain
        case .patchAlbumCover(_, let body):
            return .requestJSONEncodable(body)
        }
    }
}
