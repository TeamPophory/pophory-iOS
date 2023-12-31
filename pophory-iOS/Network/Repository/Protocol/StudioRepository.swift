//
//  StudioRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol StudioRepository {
    func fetchStudiosList(completion: @escaping (NetworkResult<FetchStudiosResponseDTO>) -> Void)
}
