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
            "X-AUTH-TOKEN": "Bearer" + "accessToken"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
}
