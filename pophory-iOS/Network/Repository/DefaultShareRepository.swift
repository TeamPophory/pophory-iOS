//
//  DefaultShareRepository.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

import Moya

final class DefaultShareRepository: BaseRepository, ShareRepository {
    
    let provider = MoyaProvider<ShareAPI>(plugins: [MoyaLoggerPlugin()])

    func patchSharePhoto(completion: @escaping (NetworkResult<PatchSharePhotoRequestDTO>) -> Void) {
        provider.request(.patchSharePhoto) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchSharePhotoRequestDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postSharePhoto(
        body: PostSharePhotoRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.postSharePhoto(body: body)) { result in
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
