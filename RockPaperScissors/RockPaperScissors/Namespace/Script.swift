//
//  Script.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/09.
//

import Foundation

@frozen enum Script {
    case input(_ currentWinner: PlayerType?)
    
    var description: String {
        switch self {
        case .input(let currentWinner):
            guard let currentWinner = currentWinner else { return "가위(1), 바위(2), 보(3)! <종료 : 0> : " }
            return "[\(currentWinner) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : "
        }
    }
}
