//
//  fetchStudiosResponseDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

struct PatchStudiosResponseDTO: Codable {
    let studios: [Studio]?
}

struct Studio: Codable {
    let id: Int?
    let name, imageUrl: String?
}
