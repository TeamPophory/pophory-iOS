//
//  BaseRepository.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/03.
//

import Foundation

class BaseRepository {

    func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data) -> NetworkResult<T> {
        print("statusCode: ", statusCode)
        switch statusCode {
        case 200..<300:
            return isValidData(data: data, responseType: T.self)
        case 400..<500:
            return .pathErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func isValidData<T: Decodable>(data: Data, responseType: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(responseType, from: data)
            return .success(decodedData)
        } catch {
            return .pathErr
        }
    }
}
