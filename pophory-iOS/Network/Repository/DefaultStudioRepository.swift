//
//  DefaultStudioRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultStudioRepository: BaseRepository, StudioRepository {
    
    let provider = MoyaProvider<StudiosAPI>(plugins: [MoyaLoggerPlugin()])
    
    func patchStudiosList(completion: @escaping (NetworkResult<PatchStudiosResponseDTO>) -> Void) {
        provider.request(.patchStudios) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchStudiosResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
