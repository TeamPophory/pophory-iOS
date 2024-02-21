//
//  DefaultStudioRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultStudioRepository: BaseRepository, StudioRepository {
    
    let provider = MoyaProvider<StudiosAPI>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggerPlugin()])
    
    func fetchStudiosList(completion: @escaping (NetworkResult<FetchStudiosResponseDTO>) -> Void) {
        provider.request(.fetchStudios) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchStudiosResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
