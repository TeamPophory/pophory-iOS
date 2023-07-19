//
//  ColorLiterals.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UIColor {
    static var pophoryPurple: UIColor {
        return UIColor(hex: "#725BFF")
    }
    static var pophoryLightPurple: UIColor {
        return UIColor(hex: "#EBE8FF")
    }
    static var pophoryRed: UIColor {
        return UIColor(hex: "#FC4646")
    }
    static var pophoryBlack: UIColor {
        return UIColor(hex: "#212121")
    }
    static var pophoryGray500: UIColor {
        return UIColor(hex: "#5F6168")
    }
    static var pophoryGray400: UIColor {
        return UIColor(hex: "#B8B9BE")
    }
    static var pophoryGray300: UIColor {
        return UIColor(hex: "#E0E1E5")
    }
    static var pophoryGray200: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    static var pophoryGray100: UIColor {
        return UIColor(hex: "#FCFCFC")
    }
    static var pophoryWhite: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

