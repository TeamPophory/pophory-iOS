//
//  DateManager.swift
//  pophory-iOS
//
//  Created by 김다예 on 2023/07/06.
//

import UIKit

class DateManager {
        
    static func dateToString(date: Date) -> String {
        
        let koreaWeekdays = ["일", "월", "화", "수", "목", "금", "토"]

        let dayformatter = DateFormatter()
        dayformatter.dateFormat = "yyyy.MM.dd"
        
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "e"
        
        guard let integerWeekdays = Int(weekFormatter.string(from: date)) else { return dayformatter.string(from: date) }
        
        let dateFormat = dayformatter.string(from: date) + "(" + koreaWeekdays[integerWeekdays - 1] + ")"
        
        return dateFormat
    }
}
