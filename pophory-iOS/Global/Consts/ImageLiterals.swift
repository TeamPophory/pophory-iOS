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
    static var settingIcon: UIImage { .load(name: "setting") }
    static var trashCanIcon: UIImage { .load(name: "delete-1") }
    static var alarmIcon: UIImage { .load(name: "alarm-1") }
    static var alarmNoticeIcon: UIImage { .load(name: "alarm") }
    static var placeholderDeleteIcon: UIImage { .load(name: "delete") }
    static var myIcon: UIImage { .load(name: "my") }
    static var chevronRightIcon: UIImage { .load(name: "right") }
    static var chevronUpIcon: UIImage { .load(name: "up") }
    static var xIcon: UIImage { .load(name: "x") }
    
    // MARK: - exception
    
    static var emptyPhotoExceptionIcon: UIImage { .load(name: "emptyPhotoExceptionIcon") }
    static var defaultPhotoIcon: UIImage { .load(name: "defaultPhotoIcon") }

    // MARK: - AlbumCover
    
    static var albumCover1: UIImage { .load(name: "ic_album_cover_friends") }
    static var albumCover2: UIImage { .load(name: "ic_album_cover_love") }
    static var albumCover3: UIImage { .load(name: "ic_album_cover_myAlbum") }
    static var albumCover4: UIImage { .load(name: "ic_album_cover_collectBook") }

    /// index 맞추기 위해 0번째에 빈 이미지 삽입
    static var albumCoverList: [UIImage] = [UIImage(), albumCover1, albumCover2, albumCover3, albumCover4]
    
    // MARK: - AlbumCoverProfile
    
    static var albumCoverProfile1: UIImage { .load(name: "albumCoverProfile1") }
    static var albumCoverProfile2: UIImage { .load(name: "albumCoverProfile2") }
    static var albumCoverProfile3: UIImage { .load(name: "albumCoverProfile3") }
    static var albumCoverProfile4: UIImage { .load(name: "albumCoverProfile4") }
    
    // MARK: - OnboardingImg
    
    static var OnboardingImage1: UIImage { .load(name: "onboardingImg1") }
    static var OnboardingImage2: UIImage { .load(name: "onboardingImg2") }
    static var OnboardingImage3: UIImage { .load(name: "onboardingImg3") }
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
