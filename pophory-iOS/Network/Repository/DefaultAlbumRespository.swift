//
//  DefaultAlbumRespository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultAlbumRespository: BaseRepository, AlbumRepository {
    
    let provider = MoyaProvider<AlbumAPI>(plugins: [MoyaLoggerPlugin()])
    
    func patchAlbumList(completion: @escaping (NetworkResult<PatchAlbumListResponseDTO>) -> Void) {
        provider.request(.patchAlbumList) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchAlbumListResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchAlbumPhotoList(
        albumId: Int,
        completion: @escaping (NetworkResult<PatchAlbumPhotoListResponseDTO>) -> Void
    ) {
        provider.request(.patchAlbumPhotoList(albumId: albumId)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchAlbumPhotoListResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
