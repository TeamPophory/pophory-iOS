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
}

extension AlbumAPI: BaseTargetType {
    var path: String {
        switch self {
        case .patchAlbumList:
            return URLConstants.album
        case .patchAlbumPhotoList(let albumId):
            return URLConstants.album + "/\(albumId)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchAlbumList, .patchAlbumPhotoList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchAlbumList, .patchAlbumPhotoList:
            return .requestPlain
        }
    }
}
