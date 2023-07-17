//
//  PhotoAPI.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

enum PhotoAPI {
    case postPhoto(body: [MultipartFormData])
    case deletePhoto(photoId: Int)
}

extension PhotoAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: BaseURLConstant.base) ?? URL(fileURLWithPath: String())
    }
    
    var headers: [String : String]? {
        switch self {
        case .postPhoto:
            let header = [
                "Content-Type": "multipart/form-dat",
                "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJpYXQiOjE2ODg0NTI4MjksImV4cCI6MTY5NzA5MjgyOSwibWVtYmVySWQiOjExfQ.iylvCn_Yapmwj-JYtz9B5zgmH5ZZXSpOlYj5oflru-nWqjFjkQWqxEnz2UuNplmG"
            ]
            return header
        case .deletePhoto:
            let header = [
                "Content-Type": "application/json",
                "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJpYXQiOjE2ODg0NTI4MjksImV4cCI6MTY5NzA5MjgyOSwibWVtYmVySWQiOjExfQ.iylvCn_Yapmwj-JYtz9B5zgmH5ZZXSpOlYj5oflru-nWqjFjkQWqxEnz2UuNplmG"
            ]
            return header
        }
    }
    
    var path: String {
        switch self {
        case .postPhoto:
            return URLConstants.photo
        case .deletePhoto(let photoId):
            return URLConstants.photo + "/\(photoId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postPhoto:
            return .post
        case .deletePhoto:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postPhoto(let body):
            return .uploadMultipart(body)
        case .deletePhoto:
            return .requestPlain
        }
    }
}
