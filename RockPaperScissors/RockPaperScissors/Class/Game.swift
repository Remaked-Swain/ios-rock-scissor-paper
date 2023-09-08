//
//  Game.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

final class Game {
    func run() {
        doRSP()
    }
    
    func doRSP() {
        
    }
}

// MARK: Resuable Methods
extension Game {
    private func input() -> InputType {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> : ")
        
        guard let input = readLine(), let intInput = Int(input) else { return .invalidInput }
        
        switch intInput {
        case 0: return .exitProgram
        case 1, 2, 3: return .handSign
        default: return .invalidInput
        }
    }
    
    private func determineWinner(computerHandSign: HandSign, userHandSign: HandSign) {
        
    }
}
