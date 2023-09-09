//
//  Game.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

final class Game {
    func run() {
        doRSP(currentWinner: nil)
    }
    
    private func doRSP(currentWinner: PlayerType?) {
        let userInput = input(currentWinner: currentWinner)
        
        guard userInput.showInputType() == .handSign else { return doRSP() }
        
        
        guard let computerHandSign = generateRandomHandSign() else { return doRSP() }
        
        
//        compareMutualHandSign(computerHandSign: computerHandSign, userHandSign: inputType)
        
    }
    
    private func menuBridge(userInput: UserInputModel, currentWinner: PlayerType?) {
        
    }
}

// MARK: Resuable Methods
extension Game {
    private func input(currentWinner: PlayerType?) -> UserInputModel {
        print(Script.input(currentWinner))
        
        guard let input = readLine(), let intInput = Int(input) else { return UserInputModel(nil) }
        
        switch intInput {
        case 0: return UserInputModel(0)
        case 1, 2, 3: return UserInputModel(intInput)
        default: return UserInputModel(nil)
        }
    }
    
    private func convertToEachHandSign(_ userInput: UserInputModel, currentWinner: PlayerType?) -> HandSign? {
        guard userInput.showInputType() == .handSign, let value = userInput.showValue() else { return nil }
        
        let isNextStep: Bool = currentWinner == nil ? false : true
        
        switch value {
        case 1: return isNextStep ? .rock : .scissors
        case 2: return isNextStep ? .scissors : .rock
        case 3: return .paper
        default: return nil
        }
    }
    
    private func generateRandomHandSign() -> HandSign? {
        HandSign.allCases.randomElement()
    }
    
    private func compareMutualHandSign(computerHandSign: HandSign?, userHandSign: HandSign?) -> GameResult {
        guard let computerHandSign = computerHandSign, let userHandSign = userHandSign else { return .rematch }
        
        switch (computerHandSign, userHandSign) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): return .win
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): return .lose
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): return .draw
        }
    }
    
    private func determineWinner(_ gameResult: GameResult) -> PlayerType? {
        switch gameResult {
        case .win: return .user
        case .lose: return .computer
        default: return nil
        }
    }
}
