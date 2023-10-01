//
//  UpdatedAccessTokenDTO.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/09/08.
//

import Foundation

struct UpdatedAccessTokenDTO: Codable {
    let accessToken: String
    let refreshToken: String
}
