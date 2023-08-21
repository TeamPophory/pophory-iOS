//
//  AsyncMoyaProvider.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/08/06.
//

import Moya

class AsyncMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    @available(iOS 15.0, *)
    func request(_ target: Target) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
