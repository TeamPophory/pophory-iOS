//
//  UserDefault+Extension.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/11.
//

import Foundation

extension UserDefaults {
    private static let keyNickname = "keyNickname"
    private static let keyFullName = "keyFullName"
}

extension UserDefaults {
    /// 사용자의 nickname 받아오기
    public func getNickname() -> String? {
        return string(forKey: UserDefaults.keyNickname)
    }
    
    /// 사용자의 nickname 등록하기
    public func setNickname(_ nickname: String?) {
        if let nickname = nickname {
            set(nickname, forKey: UserDefaults.keyNickname)
        } else {
            removeObject(forKey: UserDefaults.keyNickname)
        }
    }
    
    /// 사용자의 full name (실제 이름) 받아오기
    public func getFullName() -> String? {
        return string(forKey: UserDefaults.keyFullName)
    }
    
    /// 사용자의 full name (실제 이름) 등록하기
    public func setFullName(_ name: String?) {
        if let name = name {
            set(name, forKey: UserDefaults.keyFullName)
        } else {
            removeObject(forKey: UserDefaults.keyFullName)
        }
    }
}
