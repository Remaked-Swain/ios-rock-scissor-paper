//
//  Game.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

struct Game {
    func doRSP(currentWinner: PlayerType) {
        let userInput = input(currentWinner: currentWinner)
        let userInputType = userInput.showInputType()
        
        guard userInputType == .handSign || userInputType == .invalidInput else {
            print(Script.gameOver)
            return
        }
        
        guard userInputType == .handSign else {
            print(Script.invalidInput)
            return currentWinner == .none ? doRSP(currentWinner: .none) : doRSP(currentWinner: .computer)
        }
        
        let computerHandSign = generateRandomHandSign()
        let userHandSign = convertToEachHandSign(userInput, currentWinner: currentWinner)
        let gameResult = compareMutualHandSign(computerHandSign: computerHandSign, userHandSign: userHandSign)
        let newWinner = determineWinner(gameResult, currentWinner: currentWinner)
        
        guard currentWinner != .none, newWinner == .none else {
            noticeGameStatus(gameResult: gameResult, currentWinner: currentWinner != .none ? newWinner : currentWinner)
            return doRSP(currentWinner: newWinner)
        }
        
        noticeGameStatus(gameResult: gameResult, currentWinner: currentWinner)
    }
}

// MARK: Resuable Methods
extension Game {
    private func input(currentWinner: PlayerType) -> UserInputModel {
        let emptyString: String = ""
        print(Script.input(currentWinner), terminator: emptyString)
        
        guard let strInput = readLine(), let intInput = Int(strInput), (0...3).contains(intInput) else { return UserInputModel(nil) }
        guard intInput == 0 else { return UserInputModel(intInput) }
        return UserInputModel(0)
    }
    
    private func convertToEachHandSign(_ userInput: UserInputModel, currentWinner: PlayerType) -> HandSign? {
        guard let value = userInput.showValue() else { return nil }
        
        let isNextStep: Bool = currentWinner != .none
        
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
    
    private func compareMutualHandSign(computerHandSign computer: HandSign?, userHandSign user: HandSign?) -> GameResult {
        guard let computer = computer, let user = user else { return .draw }
        
        switch (computer, user) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            return .win
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .lose
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .draw
        }
    }
    
    private func determineWinner(_ gameResult: GameResult, currentWinner: PlayerType) -> PlayerType {
        let isNextStep: Bool = currentWinner != .none
        
        switch gameResult {
        case .win: return .user
        case .lose: return .computer
        case .draw: return isNextStep ? .none : currentWinner
        }
    }
    
    private func noticeGameStatus(gameResult: GameResult, currentWinner: PlayerType) {
        let isNextStep: Bool = currentWinner != .none
        
        switch gameResult {
        case .win:
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.win)
        case .lose:
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.lose)
        case .draw:
            print(Script.draw(currentWinner))
        }
    }
}
