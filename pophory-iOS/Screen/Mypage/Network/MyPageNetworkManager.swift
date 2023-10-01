//
//  MyPageNetworkManager.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/12.
//

import Foundation

class MyPageNetworkManager {
    
    func requestMyPageData(completion: @escaping (FetchMyPageResponseDTO?) -> Void) {
        NetworkService.shared.memberRepository.fetchMyPage(version: 2) { result in
            switch result {
            case .success(let response):
                completion(response)
            default:
                completion(nil)
            }
        }
    }
    
    func requestAllPhoto(completion: @escaping ([PhotoUrlResponseDto]?) -> Void) {
        NetworkService.shared.photoRepository.fetchAllPhoto { result in
            switch result {
            case .success(let response):
                completion(response.photos)
            default:
                completion(nil)
            }
        }
    }
    
    func requestAlbumData(completion: @escaping ([Int], Int) -> Void) {
        NetworkService.shared.albumRepository.fetchAlbumList { result in
            switch result {
            case .success(let response):
                guard let albums = response.albums else { return }
                let albumList = albums.compactMap { $0.id }
                let photoCount = albums.reduce(0) { $0 + ($1.photoCount ?? 0) }
                completion(albumList, photoCount)
            default:
                completion([], 0)
            }
        }
    }
    
    func requestPhotoData(albumList: [Int], completion: @escaping ([String]) -> Void) {
        var photoUrlList: [String] = []
        
        for albumId in albumList {
            NetworkService.shared.albumRepository.fetchAlbumPhotoList(albumId: albumId) { result in
                switch result {
                case .success(let response):
                    let photoUrls = response.photos.compactMap { $0.imageUrl }
                    photoUrlList.append(contentsOf: photoUrls)
                    completion(photoUrlList)
                default:
                    completion([])
                }
            }
        }
    }
}
