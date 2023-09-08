//
//  FetchSharePhotoRequestDTO.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

struct FetchSharePhotoRequestDTO: Codable {
    let realName: String
    let nickname: String
    let photoId: Int
    let imageUrl: String
}
