//
//  AlbumRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AlbumRepository {
    func patchAlbumList(completion: @escaping (NetworkResult<Any>) -> Void)
    func patchAlbumPhotoList(
        albumId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
}
