//
//  PostIdentityTokenDTO.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/14.
//

import Foundation

struct PostIdentityTokenDTO: Codable {
    var socialType: String
    var identityToken: String
}
