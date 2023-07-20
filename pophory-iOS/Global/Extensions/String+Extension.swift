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
    
    func isContainKoreanOnly() -> Bool {
        let koreanSet = CharacterSet(charactersIn: "가"..."힣")
        var containsOnlyKorean = true
        
        for scalar in self.unicodeScalars {
            if !koreanSet.contains(scalar) {
                containsOnlyKorean = false
                break
            }
        }
        
        return containsOnlyKorean
    }
    
    func isValidCharacters() -> Bool {
        let regEx = "^[a-zA-Z0-9._]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
}
