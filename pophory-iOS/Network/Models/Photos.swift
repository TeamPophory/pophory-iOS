//
//  Photos.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let photos: [Photo]?
}

// MARK: - PhotosResponseDto
struct PhotosResponseDto: Codable {
    let photos: [PhotoUrlResponseDto]?
}

// MARK: - Photo
struct Photo: Codable {
    let id: Int
    let studio, takenAt: String
    let imageUrl: String
    let width, height: Int
    let shareId: String
    
    init(
        id: Int
    ) {
        self.id = id
        self.studio = ""
        self.takenAt = ""
        self.imageUrl = ""
        self.width = 0
        self.height = 0
        self.shareId = ""
    }
}
