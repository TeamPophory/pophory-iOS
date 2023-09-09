//
//  AddPhotoNetworkManager.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class AddPhotoNetworkManager {
    
    func requestGetAlumListAPI(completion: @escaping (FetchAlbumListResponseDTO?) -> Void) {
        NetworkService.shared.albumRepository.fetchAlbumList() { result in
            switch result {
            case .success(let response):
                completion(response)
            default : return
            }
        }
    }
    
    func requestPostPhotoAPI(
        photoInfo: PostPhotoS3RequestDTO,
        completion: @escaping () -> Void
    ) {
        NetworkService.shared.photoRepository.postPhoto(body: photoInfo
        ) { result in
            switch result {
            case .success(_):
                completion()
            default : return
            }
        }
    }
    
    func requestGetPresignedURLAPI(completion: @escaping (FetchPresignedURLRequestDTO?) -> Void) {
        NetworkService.shared.photoRepository.fetchPresignedPhotoURL( completion: { result in
            switch result {
            case .success(let response):
                completion(response)
            default : return
            }
        })
    }
    
    func uploadImageToPresignedURL(image: UIImage, presignedURL: URL, completion: @escaping (Error?) -> Void) {
        
        // TODO: - Moya로 변환 필요
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"]))
            return
        }
        
        var request = URLRequest(url: presignedURL)
        request.httpMethod = "PUT"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpBody = imageData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) {
                completion(nil)
                print("업로드 성공")
            }
        }
        task.resume()
    }
}
