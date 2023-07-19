//
//  NetworkService.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

final class NetworkService {
    
    static let shared = NetworkService()

    private init() {}
    
    let studioRepository = DefaultStudioRepository()
    let photoRepository = DefaultPhotoRepository()
    let memberRepository = DefaultMemberRepository()
    let albumRepository = DefaultAlbumRespository()
    let authRepostiory = DefaultAuthRepository()
    let shareRepository = DefaultShareRepository()
}
