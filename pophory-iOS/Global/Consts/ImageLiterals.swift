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
    static var myAlbumPlusButtonIcon: UIImage { .load(name: "myAlbumPlusButtonIcon") }
    static var arrowUpDown: UIImage { .load(name: "arrowUpDown") }
    static var backButtonIcon: UIImage { .load(name: "backButtonIcon") }
    static var checkBigIcon: UIImage { .load(name: "checkBigIcon") }
    
    // MARK: - icon
    
    static var searchIcon: UIImage { .load(name: "searchIcon") }
    static var downIcon: UIImage { .load(name: "downIcon") }
    static var calanderIcon: UIImage { .load(name: "calanderIcon") }
    
    // MARK: - AlbumCover
    
    static var albumCover1: UIImage { .load(name: "ic_album_cover_friends") }
    static var albumCover2: UIImage { .load(name: "ic_album_cover_love") }
    static var albumCover3: UIImage { .load(name: "ic_album_cover_myAlbum") }
    static var albumCover4: UIImage { .load(name: "ic_album_cover_collectBook") }

    /// index 맞추기 위해 0번째에 빈 이미지 삽입
    static var albumCoverList: [UIImage] = [UIImage(), albumCover1, albumCover2, albumCover3, albumCover4]
    
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
