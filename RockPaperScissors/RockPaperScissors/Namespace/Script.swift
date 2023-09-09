//
//  Script.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/09.
//

import Foundation

@frozen enum Script: CustomStringConvertible {
    case input(_ currentWinner: PlayerType?)
    case invalidInput
    case win(_ currentWinner: PlayerType?)
    case lose
    case draw
    case noticeCurrentWinner(_ currentWinner: PlayerType)
    case gameOver
    
    var description: String {
        switch self {
        case .input(let currentWinner):
            guard let currentWinner = currentWinner else { return "가위(1), 바위(2), 보(3)! <종료 : 0> : " }
            return "[\(currentWinner) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : "
        case .invalidInput:
            return "잘못된 입력입니다. 다시 시도해주세요."
        case .win(let currentWinner):
            guard let currentWinner = currentWinner else { return "이겼습니다!" }
            return "\(currentWinner)의 승리!"
        case .lose:
            return "졌습니다!"
        case .draw:
            return "비겼습니다!"
        case .noticeCurrentWinner(let currentWinner):
            return "\(currentWinner)의 턴입니다."
        case .gameOver:
            return "게임 종료"
        }
    }
}
