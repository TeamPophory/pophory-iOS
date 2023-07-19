//
//  PhotoUrlResponseDto.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/19.
//

import Foundation

// MARK: - PhotoUrlResponseDto

struct PhotoUrlResponseDto: Codable {
    let photoId: Int?
    let photoUrl: String?
    let shareId: String?
}
