//
//  PatchAlbumListResponseDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct PatchAlbumListResponseDTO: Codable {
    let albums: [Album]?
}

// MARK: - Album
struct Album: Codable {
    let id: Int?
    let title: String?
    let albumCover: Int?
    let photoCount: Int?
    let photoLimit: Int?
}
