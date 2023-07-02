//
//  ColorLiterals.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/06/27.
//

import UIKit

extension UIColor {
    static var purple: UIColor {
        return UIColor(hex: "#725BFF")
    }
    static var red: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    static var black: UIColor {
        return UIColor(hex: "#212121")
    }
    static var gray500: UIColor {
        return UIColor(hex: "#5F6168")
    }
    static var gray400: UIColor {
        return UIColor(hex: "#B8B9BE")
    }
    static var gray300: UIColor {
        return UIColor(hex: "#E0E1E5")
    }
    static var gray200: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    static var gray100: UIColor {
        return UIColor(hex: "#FCFCFC")
    }
    static var white: UIColor {
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

