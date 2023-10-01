//
//  DefaultAuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

final class DefaultAuthRepository: BaseRepository, AuthRepository {
    
    let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])
    
    func submitAppleAuthorizationCode(code: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.postAuthorizationCode(authorizationCode: code)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(.success("Apple authorization code sent successfully."))
                } else {
                    completion(.requestErr("Failed to send Apple authorization code."))
                }
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    func submitIdentityToken(tokenDTO: PostIdentityTokenDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.postIdentityToken(identityToken: tokenDTO.identityToken , socialType: tokenDTO.socialType)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 401 {
                    print("✅Server response: \(response)")
                    self.updateRefreshToken { refreshResult in
//                        NotificationCenter.default.post(name: .didReceiveUnauthorizedNotification, object: nil) 
                        switch refreshResult {
                        case .success:
                            // 토큰 갱신 성공. 원래 요청 재시도 또는 적절한 처리...
                            self.submitIdentityToken(tokenDTO: tokenDTO, completion: completion)
                        case .requestErr(let message):
                            // 토큰 갱신 실패. 오류 메시지 출력 또는 적절한 처리...
                            print("Failed to update access token:", message)
                            completion(.requestErr(message))
                        case .pathErr:
                            print("Path error")
                            completion(.pathErr)
                        case .serverErr:
                            print("Server error")
                            completion(.serverErr)
                        case .networkFail:
                            print("Network failure")
                            completion(.networkFail)
                        case .sharePhotoErr(_):
                            print("sharePhotoErr")
                        case .unauthorized:
                            print("unauthorized")
                        }
                    }
                } else if response.statusCode < 300 {
                    do {
                        let loginResponse = try response.map(PostLoginAPIDTO.self)
                        completion(.success(loginResponse))
                    } catch {
                        print("Error decoding the login response: \(error)")
                        completion(.requestErr("Failed to decode the login response."))
                    }
                } else {
                    completion(.requestErr("Failed to send Identity Token."))
                }
            case .failure(let error):
                print("🚨Error: \(error)")
                completion(.networkFail)
            }
        }
    }
    
    func updateRefreshToken(completion: @escaping (NetworkResult<Any>) -> Void) {
        guard let refreshToken = UserDefaults.standard.string(forKey: OnboardingViewController.userDefaultsRefreshTokenKey) else {
            completion(.requestErr("No refresh token found"))
            return
        }
        
        let requestDTO = PostRefreshTokenDTO(refreshToken: refreshToken)
        
        provider.request(.refreshToken(refreshToken: requestDTO.refreshToken)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    do {
                        let loginResponse = try response.map(UpdatedAccessTokenDTO.self)
                        completion(.success((loginResponse)))
                        print("Successfully refreshed access token")
                    } catch {
                        print("Error decoding the login response: \(error)")
                        completion(.requestErr("Failed to decode the login response."))
                    }
                } else {
                    completion(.requestErr("Failed to update access token."))
                }
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.withdrawUser) { result in
            switch result {
            case.success(_):
                completion(.success((Any).self))
            case .failure(let err):
                print(err)
            }
        }
    }
}
