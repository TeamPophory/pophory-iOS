//
//  PophoryAdManager.swift
//  pophory-iOS
//
//  Created by 강윤서 on 10/31/23.
//

import Foundation

final class PophoryAdManager {
    static let shared = PophoryAdManager()
    
    private init() {}
    
    private var userDefaultsEditAlbumAd = ""
    
    func setEditAlbumAd(_ AdName: String?) {
        userDefaultsEditAlbumAd = AdName ?? ""
    }
    
    func saveEditAlbumAd(_ AdId: String?) {
        UserDefaults.standard.set(AdId, forKey: userDefaultsEditAlbumAd)
    }
    
    func fetchEditAlbumAd() -> String? {
        return UserDefaults.standard.string(forKey: userDefaultsEditAlbumAd)
    }
}
