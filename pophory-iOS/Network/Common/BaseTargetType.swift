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
            "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJpYXQiOjE2ODg0ODM0MzAsImV4cCI6MTY5NTY4MzQzMCwibWVtYmVySWQiOjB9.IPqtz7F4TJa0AFVZ9WRVWq9IGNt9Mhh_tpQWO39Ml1hRKfz-W86z1VpDcrYOIELM"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
}
