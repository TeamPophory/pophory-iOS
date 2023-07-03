//
//  AuthRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

protocol AuthRepository {
    func withdraw(completion: @escaping (NetworkResult<Any>) -> Void)
}
