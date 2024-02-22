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
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        return url
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
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    func getAccessTokenFromUserDefaults() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
}
