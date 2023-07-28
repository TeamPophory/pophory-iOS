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
    
    func fetchMyPage(version: Int, completion: @escaping (NetworkResult<FetchMyPageResponseDTO>) -> Void) {
        let api: MemberAPI
        switch version {
        case 1:
            api = .fetchMyPage
        case 2:
            api = .fetchMyPageV2
        default:
            fatalError("[fetchMyPage] 올바르지 않은 버전 번호입니다.")
        }
        
        provider.request(api) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchMyPageResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func fetchSignUp(
        body: FetchSignUpRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.signUp(body: body)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                completion(.success(()))
            case .failure(let err):
                completion(.networkFail)
            }
        }
    }
    
    func fetchUserInfo(completion: @escaping (NetworkResult<FetchUserInfoResponseDTO>) -> Void) {
        provider.request(.patchUserInfo) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult: NetworkResult<FetchUserInfoResponseDTO> = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func checkDuplicateNickname(nickname: String, completion: @escaping (NetworkResult<Bool>) -> Void) {
        provider.request(.checkDuplicateNickname(nickname: nickname)) { result in
            switch result {
            case .success(let response):
                do {
                    let responseObject = try JSONDecoder().decode([String: Bool].self, from: response.data)
                    if let isDuplicated = responseObject["isDuplicated"] {
                        completion(.success(isDuplicated))
                    } else {
                        completion(.success(false))
                    }
                } catch {
                    completion(.pathErr)
                }
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
}
