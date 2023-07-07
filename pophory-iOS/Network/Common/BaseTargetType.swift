//
//  BaseTargetType.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {

    var baseURL: URL {
        return URL(string: BaseURLConstant.base) ?? URL(fileURLWithPath: String())
    }

    var headers: [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJpYXQiOjE2ODg0NTI4MjksImV4cCI6MTY5NzA5MjgyOSwibWVtYmVySWQiOjExfQ.iylvCn_Yapmwj-JYtz9B5zgmH5ZZXSpOlYj5oflru-nWqjFjkQWqxEnz2UuNplmG"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
}
