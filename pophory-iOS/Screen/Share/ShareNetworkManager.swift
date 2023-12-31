//
//  ShareNetworkManager.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/20.
//

import Foundation

class ShareNetworkManager {
    
    static let shared = ShareNetworkManager()
    
    var toPostPhotoID: Int?

    private init() { }
    
    func requestGetSharePhoto(
        shareID: String,
        completion: @escaping (FetchSharePhotoRequestDTO?) -> Void,
        completionError: @escaping () -> Void
    ) {
        NetworkService.shared.shareRepository.fetchSharePhoto(shareId: shareID) { result in
            switch result {
            case .success(let response):
                self.toPostPhotoID = response.photoId
                completion(response)
            default:
                completionError()
            }
        }
    }
    
    func requestPostSharePhoto(
        completion: @escaping (PostSharePhotoRequestDTO?) -> Void) {
        guard let photoID = self.toPostPhotoID else { return }
        NetworkService.shared.shareRepository.postSharePhoto(photoID: photoID) { result in
            switch result {
            case .sharePhotoErr(let response):
                completion(response)
            default:
                return
            }
        }
        self.toPostPhotoID = nil
    }
}
