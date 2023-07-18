//
//  PhotoRespository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

protocol PhotoRepository {
    
    func patchPresignedPhotoURL(completion: @escaping (NetworkResult<PatchPresignedURLRequestDTO>) -> Void)

    func postPhoto(
        body: [MultipartFormData],
        completion: @escaping (NetworkResult<Any>) -> Void
    )
    func deletePhoto(
        photoId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
}
