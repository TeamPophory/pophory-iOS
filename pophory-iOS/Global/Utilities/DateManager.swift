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
}
