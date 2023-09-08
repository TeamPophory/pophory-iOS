//
//  AlbumRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AlbumRepository {
    func fetchAlbumList(
        completion: @escaping (NetworkResult<FetchAlbumListResponseDTO>) -> Void
    )
    func fetchAlbumPhotoList(
        albumId: Int,
        completion: @escaping (NetworkResult<FetchAlbumPhotoListResponseDTO>) -> Void
    )
    func patchAlbumCover(
        albumId: Int,
        body: patchAlbumCoverRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
}
