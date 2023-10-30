//
//  URLList.swift
//  pophory-iOS
//
//  Created by 강윤서 on 2023/10/27.
//

import Foundation

/// 뷰 이름 + 이동 URL 정보로 이름 작성
enum WebViewURLList {
    case mypageBannerAd
    case mypagePophoryStory
    case settingNotice
    case settingPrivacyPolicy
    case settingTerms
    
    var url: String {
        switch self {
        case .mypageBannerAd:
            return "https://walla.my/pophory_event3?utm_source=ios"
        case .mypagePophoryStory:
            return "https://pophoryofficial.wixsite.com/pophory/porit-story"
        case .settingNotice:
            return "https://pophoryofficial.wixsite.com/pophory/notice"
        case .settingPrivacyPolicy:
            return "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy2"
        case .settingTerms:
            return "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy1"
        }
    }
}
