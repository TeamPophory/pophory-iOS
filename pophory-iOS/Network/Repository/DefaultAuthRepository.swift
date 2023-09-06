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
                if response.statusCode < 300 {
                    do {
                        let loginResponse = try response.map(LoginAPIDTO.self)
                        completion(.success(loginResponse))
                    } catch {
                        print("Error decoding the login response: \(error)")
                        completion(.requestErr("Failed to decode the login response."))
                    }
                } else {
                    completion(.requestErr("Failed to send Identity Token."))
                }
            case .failure(let error):
                print(error)
                completion(.networkFail)
            }
        }
    }
    
    func updateRefreshToken(completion: @escaping (NetworkResult<Any>) -> Void) {
            guard let refreshToken = UserDefaults.standard.string(forKey: OnboardingViewController.userDefaultsRefreshTokenKey) else {
                completion(.requestErr("No refresh token found"))
                return
            }

            let requestDTO = RefreshTokenDTO(refreshToken: refreshToken)

            provider.request(.refreshToken(refreshToken: requestDTO.refreshToken)) { result in
                switch result {
                case .success(let response):
                    if response.statusCode < 300 {
                        do {
                            let loginResponse = try response.map(LoginAPIDTO.self)
                            completion(.success((loginResponse)))
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
