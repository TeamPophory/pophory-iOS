//
//  BaseTargetType.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {
    var authToken: String? { get }
}

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: BaseURLConstant.base) ?? URL(fileURLWithPath: String())
    }

    var headers: [String: String]? {
        var header = [
            "Content-Type": "application/json"
        ]
        if let token = authToken {
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }

    var sampleData: Data {
        return Data()
    }
    
    func getAccessTokenFromUserDefaults() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
}
