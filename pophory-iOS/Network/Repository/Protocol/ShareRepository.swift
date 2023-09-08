//
//  ShareRepository.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

protocol ShareRepository {
    
    func fetchSharePhoto(shareId: String, completion: @escaping (NetworkResult<FetchSharePhotoRequestDTO>) -> Void)

    func postSharePhoto(photoID: Int, completion: @escaping (NetworkResult<PostSharePhotoRequestDTO>) -> Void)
}
