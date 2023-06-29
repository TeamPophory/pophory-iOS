//
//  Date+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import Foundation

extension Date {
    /// DateFormat으로 변형한 String 반환
    /// - Parameter format: 변형할 DateFormat (ex: "yyyy-MM-dd")
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)!
        
        return formatter.string(from: self)
    }
}
