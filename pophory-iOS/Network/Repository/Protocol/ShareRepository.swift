//
//  ShareRepository.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

protocol ShareRepository {
    
    func patchSharePhoto(shareId: String, completion: @escaping (NetworkResult<PatchSharePhotoRequestDTO>) -> Void)

    func postSharePhoto(photoID: Int, completion: @escaping (NetworkResult<PostSharePhotoRequestDTO>) -> Void)
}
