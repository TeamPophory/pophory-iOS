//
//  AdRepository.swift
//  pophory-iOS
//
//  Created by 강윤서 on 10/31/23.
//

import Foundation

import Moya

protocol AdRepository {
    
    func fetchAdInfo(os: String, version: String, completion: @escaping (NetworkResult<[FetchAdResponseDTO]>) -> Void?)
}
