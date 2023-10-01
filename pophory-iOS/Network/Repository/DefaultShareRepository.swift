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

    func fetchSharePhoto(shareId: String, completion: @escaping (NetworkResult<FetchSharePhotoRequestDTO>) -> Void) {
        provider.request(.fetchSharePhoto(shareID: shareId)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchSharePhotoRequestDTO> = self.judgeStatus(by: statusCode, data)
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
