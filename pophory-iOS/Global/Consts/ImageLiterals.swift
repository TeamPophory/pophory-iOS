//
//  ImageLiterals.swift
//  pophory-iOS
//
//  Created by 홍준혁 on 2023/07/02.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - tab bar icon
    
    static var tabBarHomeAlbumIcon: UIImage { .load(name: "tabBarHomeAlbumIcon") }
    static var tabBarEditAlbumIcon: UIImage { .load(name: "tabBarEditAlbumIcon") }
    static var tabBarMyPageIcon: UIImage { .load(name: "tabBarMyPageIcon") }
    
    //MARK: - logo icon
    
    static var logIcon: UIImage { .load(name: "logIcon") }
    
    // MARK: - icon

    static var searchIcon: UIImage { .load(name: "searchIcon") }
    static var downIcon: UIImage { .load(name: "downIcon") }
    static var calanderIcon: UIImage { .load(name: "calanderIcon") }

}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}
