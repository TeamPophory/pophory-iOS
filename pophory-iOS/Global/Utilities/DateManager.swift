//
//  DateManager.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/06.
//

import UIKit

class DateManager {
    
    static func dateToString(date: Date) -> String {
        
        let dayformatter = DateFormatter()
        dayformatter.dateFormat = "yyyy.MM.dd"
        
        let dateFormat = dayformatter.string(from: date)
        
        return dateFormat
    }
    
    static func stringToDate(date: String?) -> Date? {
        
        let dayformatter = DateFormatter()
        dayformatter.dateFormat = "yyyy.MM.dd"
        
        guard let date = date else { return nil }
        
        let dateFormat = dayformatter.date(from: date)
        return dateFormat
    }
}
