//
//  URLConstants.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

// TODO: - URL V1 -> V2 버저닝 필요

struct URLConstants {
    static let studio = "/api/v1/studios"
    static let photo = "/api/v1/photo"
    static let memeber = "/api/v1/member"
    static let album = "/api/v1/albums"
    static let auth = "/api/v1/auth"
}

struct URLConstantsV2 {
    static let studio = "/api/v1/studios"
    static let photo = "/api/v2/photo"
    static let memeber = "/api/v2/member"
    static let album = "/api/v2/album"
    static let auth = "/api/v2/auth"
    static let share = "/api/v2/share"
    static let v3 = "/api/v2/s3"
    static let ad = "/api/v2/ad"
}
