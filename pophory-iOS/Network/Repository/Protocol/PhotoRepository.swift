//
//  PhotoRespository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

import Moya

protocol PhotoRepository {
    
    func fetchAllPhoto(completion: @escaping (NetworkResult<PhotosResponseDto>) -> Void)
    
    func fetchPresignedPhotoURL(completion: @escaping (NetworkResult<FetchPresignedURLRequestDTO>) -> Void)

    func postPhoto(
        body: PostPhotoS3RequestDTO,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
    func deletePhoto(
        photoId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    )
}
