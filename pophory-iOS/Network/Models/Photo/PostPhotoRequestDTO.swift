//
//  PostPhotoS3RequestDTO.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation
import UIKit

struct PostPhotoS3RequestDTO: Codable {
    let fileName: String?
    let albumId: Int?
    let takenAt: String?
    let studioId: Int?
    let width: Int?
    let height: Int?
}
