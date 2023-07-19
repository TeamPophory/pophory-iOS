//
//  PatchUserInfoResponseDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct FetchUserInfoResponseDTO: Codable {
    let id: Int?
    let realName, nickname, profileImageUrl: String?
    let photoCount: String?
}
