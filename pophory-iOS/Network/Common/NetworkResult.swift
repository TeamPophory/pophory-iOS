//
//  NetworkResult.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

enum NetworkResult<T> {
    case success(T)                    // 서버 통신 성공했을 때,
    case requestErr(T)            // 요청 에러 발생했을 때,
    case unauthorized             // 401 Unauthorized 응답 받았을 때,
    case pathErr                        // 경로 에러 발생했을 때,
    case serverErr                    // 서버의 내부적 에러가 발생했을 때,
    case networkFail                // 네트워크 연결 실패했을 때
    case sharePhotoErr(T)              // 내가 공유한 사진을 내가 수락했을 때
}
