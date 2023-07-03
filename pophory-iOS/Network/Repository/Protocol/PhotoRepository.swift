//
//  PhotoRespository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol PhotoRepository {
    func postPhoto(
        body: PostPhotoRequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
    func deletePhoto(
        photoId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
}
