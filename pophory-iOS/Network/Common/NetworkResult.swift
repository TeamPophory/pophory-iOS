//
//  NetworkResult.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

enum NetworkResult<T> {
    /// 서버 통신 성공
    case success(T)
    /// 요청 에러 발생
    case requestErr(T)
    /// 401 Unauthorized 응답시
    case unauthorized
    /// 경로 에러 발생
    case pathErr
    /// 서버의 내부적 에러가 발생
    case serverErr
    /// 네트워크 연결 실패
    case networkFail
    /// 본인이 공유한 사진을 본인이 수락시
    case sharePhotoErr(T)
}
