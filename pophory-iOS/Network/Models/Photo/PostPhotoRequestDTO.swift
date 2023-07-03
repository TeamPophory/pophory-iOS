//
//  postPhotoRequestDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct PostPhotoRequestDTO: Codable {
    let photo: String?
    let object: PhotoObject?
}

struct PhotoObject: Codable {
    let albumId: Int?
    let takenAt: String?
    let studioId: Int?
}
