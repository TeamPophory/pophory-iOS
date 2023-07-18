//
//  PatchPresignedURLRequestDTO.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/18.
//

import Foundation

struct PatchPresignedURLRequestDTO: Codable {
    let presignedUrl: String
    let fileName: String
}
