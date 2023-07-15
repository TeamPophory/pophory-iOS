//
//  PopupType.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/15.
//

import Foundation

enum PopupType {
    /// 확인 버튼 하나 있는 경우 (디폴트 액션: 팝업 닫기)
    case simple
    
    /// 선택할 수 있는 옵션이 있는 경우 (검은 버튼 한 개: 디폴트 액션 팝업 닫기, 회색 버튼 한 개)
    case option
    
    /// 선택할 수 있는 옵션이 있지만, 하나가 버튼이 아닌 작은 글씨로 되어 있는 경우 (예: 탈퇴하기)
    case biasedOption
}
