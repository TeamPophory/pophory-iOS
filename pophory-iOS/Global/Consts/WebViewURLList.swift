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
    
    var url: URL {
        switch self {
        case .mypageBannerAd:
            return stringToURL(urlString: "https://www.figma.com/file/giJI7XdVoEcDMVDEeaStLe/3%EC%B0%A8-%EC%8A%A4%ED%94%84%EB%A6%B0%ED%8A%B8?type=design&node-id=1401-17024&mode=design&t=x5WBazl8fQ68va0R-0")
        case .mypagePophoryStory:
            return stringToURL(urlString: "https://pophoryofficial.wixsite.com/pophory/porit-story")
        case .settingNotice:
            return stringToURL(urlString: "https://pophoryofficial.wixsite.com/pophory/notice")
        case .settingPrivacyPolicy:
            return stringToURL(urlString: "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy2")
        case .settingTerms:
            return stringToURL(urlString: "https://pophoryofficial.wixsite.com/pophory/%EC%A0%95%EC%B1%85#policy1")
        }
    }
}

extension WebViewURLList {
    private func stringToURL(urlString: String) -> URL {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
        } else {
            print("Invalid URL")
        }
        return url
    }
}
