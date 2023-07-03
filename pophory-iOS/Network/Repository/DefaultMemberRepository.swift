//
//  DefaultMemberRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultMemberRepository: BaseRepository, MemberRepository {
    
    let provider = MoyaProvider<MemberAPI>(plugins: [MoyaLoggerPlugin()])
    
    func patchMyPage(completion: @escaping (NetworkResult<PatchMyPageResponseDTO>) -> Void) {
        provider.request(.patchMyPage) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchMyPageResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchSignUp(
        body: PatchSignUpRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.signUp(body: body)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                completion(.success((Any).self))
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchUserInfo(completion: @escaping (NetworkResult<PatchUserInfoResponseDTO>) -> Void) {
        provider.request(.patchMyPage) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<PatchUserInfoResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
}
