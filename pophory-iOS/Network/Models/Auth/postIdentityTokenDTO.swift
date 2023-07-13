//
//  sendIdentityTokenDTO.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/14.
//

import Foundation

struct postIdentityTokenDTO: Codable {
    let socialType: String?
    let identityToken: String?
}
