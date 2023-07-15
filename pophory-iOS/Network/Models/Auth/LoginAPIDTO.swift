//
//  LoginAPIDTO.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/15.
//

import Foundation

struct LoginAPIDTO: Codable {
    let accessToken: String
    let refreshToken: String
    let isRegistered: Bool
}
