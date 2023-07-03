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

// MARK: - Photo
struct Photo: Codable {
    let id: Int?
    let studio, takenAt, imageUrl: String?
}
