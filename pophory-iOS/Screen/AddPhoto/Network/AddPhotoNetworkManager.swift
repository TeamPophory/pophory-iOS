//
//  AddPhotoNetworkManager.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/19.
//

import UIKit

class AddPhotoNetworkManager {
    
    func requestGetAlumListAPI(completion: @escaping (PatchAlbumListResponseDTO?) -> Void) {
        NetworkService.shared.albumRepository.patchAlbumList() { result in
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
    
    func requestGetPresignedURLAPI(completion: @escaping (PatchPresignedURLRequestDTO?) -> Void) {
        NetworkService.shared.photoRepository.patchPresignedPhotoURL( completion: { result in
            switch result {
            case .success(let response):
                completion(response)
            default : return
            }
        })
    }
    
    func uploadImageToPresignedURL(image: UIImage, presignedURL: URL, completion: @escaping (Error?) -> Void) {
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
            
            // Check the response status code to ensure successful upload
            if let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) {
                completion(nil)  // Upload successful
                print("업로드 성공")
            }
        }
        task.resume()
    }
}
