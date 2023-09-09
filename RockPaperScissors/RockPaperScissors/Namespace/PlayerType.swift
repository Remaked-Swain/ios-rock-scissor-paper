//
//  PlayerType.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/09.
//

import Foundation

@frozen enum PlayerType: CustomStringConvertible {
    case computer, user
    
    var description: String {
        switch self {
        case .computer: return "컴퓨터"
        case .user: return "사용자"
        }
    }
}
