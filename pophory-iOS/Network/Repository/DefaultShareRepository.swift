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

    func patchSharePhoto(shareId: String, completion: @escaping (NetworkResult<PatchSharePhotoRequestDTO>) -> Void) {
        provider.request(.patchSharePhoto(shareID: shareId)) { result in
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
    
    func postSharePhoto(photoID: Int, completion: @escaping (NetworkResult<PostSharePhotoRequestDTO>) -> Void) {
        provider.request(.postSharePhoto(photoID: photoID)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PostSharePhotoRequestDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
