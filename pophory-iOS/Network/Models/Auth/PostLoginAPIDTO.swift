//
//  PostLoginAPIDTO.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/15.
//

import Foundation

struct PostLoginAPIDTO: Codable {
    let accessToken: String
    let refreshToken: String
    let isRegistered: Bool
}
