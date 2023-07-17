//
//  patchSignUpRequestDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct PatchSignUpRequestDTO: Codable {
    let realName, nickname: String?
    let albumCover: Int?
}
