//
//  Script.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/09.
//

import Foundation

@frozen enum Script: CustomStringConvertible {
    case input(_ currentWinner: PlayerType)
    case invalidInput
    case win
    case lose
    case draw(_ currentWinner: PlayerType)
    case noticeCurrentWinner(_ currentWinner: PlayerType)
    case gameOver
    
    var description: String {
        switch self {
        case .input(let currentWinner):
            return currentWinner == .none ? "가위(1), 바위(2), 보(3)! <종료 : 0> : " : "[\(currentWinner) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : "
        case .invalidInput:
            return "잘못된 입력입니다. 다시 시도해주세요."
        case .win:
            return "이겼습니다!"
        case .lose:
            return "졌습니다!"
        case .draw(let currentWinner):
            return currentWinner == .none ? "비겼습니다!" : "\(currentWinner)의 승리!"
        case .noticeCurrentWinner(let currentWinner):
            return "\(currentWinner)의 턴입니다."
        case .gameOver:
            return "게임 종료"
        }
    }
}
