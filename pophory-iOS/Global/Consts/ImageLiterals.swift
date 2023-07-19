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
    
    static var launchIcon: UIImage { .load(name: "launchIcon") }
    static var logIcon: UIImage { .load(name: "logIcon") }
    static var myAlbumPlusButtonIcon: UIImage { .load(name: "myAlbumPlusButtonIcon") }
    static var arrowUpDown: UIImage { .load(name: "arrowUpDown") }
    static var backButtonIcon: UIImage { .load(name: "backButtonIcon") }
    static var checkBigIcon: UIImage { .load(name: "checkBigIcon") }
    static var checkBigIconWhite: UIImage { .load(name: "checkBigIconWhite") }
    
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
    static var emptyFeedIcon: UIImage { .load(name: "emptyFeedIcon") }
    static var changeElbumCover: UIImage { .load(name: "changeElbumCover") }
    static var progressBarIcon: UIImage { .load(name: "progressBarIcon") }
    static var progressBarIconFull: UIImage { .load(name: "progressBarIconFull") }
    static var shareIcon: UIImage {
        .load(name: "Share")
    }
    
    // MARK: - exception
    
    static var emptyPhotoExceptionIcon: UIImage { .load(name: "emptyPhotoExceptionIcon") }
    static var defaultPhotoIcon: UIImage { .load(name: "defaultPhotoIcon") }

    // MARK: - AlbumCover
    
    static var albumCover1: UIImage { .load(name: "ic_album_cover_friends_1") }
    static var albumCover2: UIImage { .load(name: "ic_album_cover_friends_2") }
    static var albumCover3: UIImage { .load(name: "ic_album_cover_love_1") }
    static var albumCover4: UIImage { .load(name: "ic_album_cover_love_2") }
    static var albumCover5: UIImage { .load(name: "ic_album_cover_my_1") }
    static var albumCover6: UIImage { .load(name: "ic_album_cover_my_2") }
    static var albumCover7: UIImage { .load(name: "ic_album_cover_family_1") }
    static var albumCover8: UIImage { .load(name: "ic_album_cover_family_2") }

    /// index 맞추기 위해 0번째에 빈 이미지 삽입
    static var albumCoverList: [UIImage] = [
        UIImage(),
        albumCover1,
        albumCover2,
        albumCover3,
        albumCover4,
        albumCover5,
        albumCover6,
        albumCover7,
        albumCover8
    ]
    
    // MARK: - AlbumCoverProfile
    
    static var albumCoverProfile1: UIImage { .load(name: "albumCoverProfile1") }
    static var albumCoverProfile2: UIImage { .load(name: "albumCoverProfile2") }
    static var albumCoverProfile3: UIImage { .load(name: "albumCoverProfile3") }
    static var albumCoverProfile4: UIImage { .load(name: "albumCoverProfile4") }
    static var albumCoverProfile1Alpa: UIImage { .load(name: "albumCoverProfile1Alpa") }
    static var albumCoverProfile2Alpa: UIImage { .load(name: "albumCoverProfile2Alpa") }
    static var albumCoverProfile3Alpa: UIImage { .load(name: "albumCoverProfile3Alpa") }
    static var albumCoverProfile4Alpa: UIImage { .load(name: "albumCoverProfile4Alpa") }
    
    static var albumCoverProfileList: [UIImage] = [UIImage(), albumCoverProfile1, albumCoverProfile2, albumCoverProfile3, albumCoverProfile4]

    // MARK: - OnboardingImg
    
    static var OnboardingImage1: UIImage { .load(name: "onboardingImg1") }
    static var OnboardingImage2: UIImage { .load(name: "onboardingImg2") }
    static var OnboardingImage3: UIImage { .load(name: "onboardingImg3") }
    static var OnboardingImage4: UIImage { .load(name: "OnboardingImage4") }
    
    static var congratuation: UIImage { .load(name: "img_congratuation") }
    
    // MARK: - PopUpImg
    
    static var img_albumfull: UIImage { .load(name: "img_albumfull") }
    
    // MARK: - BackgroundImg
    
    static var addPhotoBackgroundVertical: UIImage { .load(name: "img_background_height") }
    static var addPhotoBackgroundHorizontal: UIImage { .load(name: "img_background_width") }

    // MARK: - MypageImg
    
    static var defaultProfile: UIImage { .load(name: "defaultProfile") }
    static var defaultBannerAd: UIImage { .load(name: "bannerAdDefault") }
    static var myPageShareBanner: UIImage { .load(name: "myPageShareBanner") }
    
    // MARK: - ErrorImg

    static var networkFail: UIImage { .load(name: "networkFail") }
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
