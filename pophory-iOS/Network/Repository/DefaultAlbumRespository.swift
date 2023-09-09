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
    
    func fetchAlbumList(completion: @escaping (NetworkResult<FetchAlbumListResponseDTO>) -> Void) {
        provider.request(.fetchAlbumList) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchAlbumListResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func fetchAlbumPhotoList(
        albumId: Int,
        completion: @escaping (NetworkResult<FetchAlbumPhotoListResponseDTO>) -> Void
    ) {
        provider.request(.fetchAlbumPhotoList(albumId: albumId)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchAlbumPhotoListResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchAlbumCover(
        albumId: Int,
        body: patchAlbumCoverRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.patchAlbumCover(albumId: albumId, body: body)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                completion(.success(()))
            case .failure(let err):
                print(err)
            }
        }
    }
}
