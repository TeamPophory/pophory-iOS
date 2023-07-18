//
//  DefaultPhotoRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultPhotoRepository: BaseRepository, PhotoRepository {
    
    let provider = MoyaProvider<PhotoAPI>(plugins: [MoyaLoggerPlugin()])
    
    func patchPresignedPhotoURL(completion: @escaping (NetworkResult<PatchPresignedURLRequestDTO>) -> Void) {
        provider.request(.patchPresignedPhotoURL) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchPresignedURLRequestDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postPhoto(
        body: [MultipartFormData],
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.postPhoto(body: body)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                completion(.success((Any).self))
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deletePhoto(
        photoId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.deletePhoto(photoId: photoId)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                completion(.success((Any).self))
            case .failure(let err):
                print(err)
            }
        }
    }
}
