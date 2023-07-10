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
    
    func isContainValidKorean(length: Int) -> Bool {
        if length < 2 {
            return true
        }

        let pattern = "^(?=([가-힣]|[ㄱ-ㅎ]))(?<![ㄱ-ㅎ]{2,}).*$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        return regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: length)) > 0
    }
}
