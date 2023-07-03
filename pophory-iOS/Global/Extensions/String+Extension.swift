//
//  String+Extension.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import Foundation

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func isContainNumberAlphabetAndSpecialCharacters() -> Bool {
        let pattern = "^[0-9a-zA-Z!@#$%^&*()-=+] [!@$%^&+=]*$"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false }
        return true
    }
}
