//
//  postPhotoRequestDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation
import UIKit

struct PostPhotoRequestDTO: Codable {
    let photo: Data?
    let object: PhotoObject?
}

struct PhotoObject: Codable {
    var albumId: Int?
    var takenAt: String?
    var studioId: Int?
}
