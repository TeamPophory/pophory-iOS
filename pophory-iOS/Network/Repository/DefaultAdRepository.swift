//
//  DefaultAdRepository.swift
//  pophory-iOS
//
//  Created by 강윤서 on 10/31/23.
//

import Foundation

import Moya

final class DefaultAdRepository: BaseRepository, AdRepository {
    
    let provider = MoyaProvider<AdAPI>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggerPlugin()])
    
    func fetchAdInfo(os: String, version: String, completion: @escaping (NetworkResult<[FetchAdResponseDTO]>) -> Void?) {
        provider.request(.fetchAdInfo(os: os, version: version)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<[FetchAdResponseDTO]> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
