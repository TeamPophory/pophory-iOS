//
//  FetchMyPageResponseDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct FetchMyPageResponseDTO: Codable {
    let realName, nickname, profileImage: String?
    let photoCount: Int?
    let photos: Photos?
}
