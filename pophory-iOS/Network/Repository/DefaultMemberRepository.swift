//
//  DefaultMemberRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultMemberRepository: BaseRepository, MemberRepository {
    
    let provider: AsyncMoyaProvider<MemberAPI>

    init(provider: AsyncMoyaProvider<MemberAPI> = AsyncMoyaProvider<MemberAPI>(session: Session(interceptor: AuthInterceptor.shared), plugins: [MoyaLoggerPlugin()])) {
        self.provider = provider
    }
    
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
    
    func submitSignUp(body: patchSignUpRequestDTO) async throws {
        do {
            let response = try await provider.request(.patchSignUp(body: body))
        } catch {
            throw error
        }
    }
    
    func fetchUserInfo(completion: @escaping (NetworkResult<FetchUserInfoResponseDTO>) -> Void) {
        provider.request(.fetchUserInfo) { result in
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
    
    func requestDuplicateNicknameCheck(nickname: String) async throws -> Bool {
        let response: Response
        response = try await provider.request(.checkDuplicateNickname(nickname: nickname))

        let boolResponse = try response.map(PostIsDuplicatedDTO.self)
        return boolResponse.isDuplicated
    }
}
