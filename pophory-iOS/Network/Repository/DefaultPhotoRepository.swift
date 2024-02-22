//
//  DefaultPhotoRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultPhotoRepository: BaseRepository, PhotoRepository {
    
    let provider = MoyaProvider<PhotoAPI>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggerPlugin()])
    
    func fetchAllPhoto(completion: @escaping (NetworkResult<PhotosResponseDto>) -> Void) {
        provider.request(.fetchAllPhotos) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PhotosResponseDto> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func fetchPresignedPhotoURL(completion: @escaping (NetworkResult<FetchPresignedURLRequestDTO>) -> Void) {
        provider.request(.fetchPresignedPhotoURL) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchPresignedURLRequestDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postPhoto(
        body: PostPhotoS3RequestDTO,
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
