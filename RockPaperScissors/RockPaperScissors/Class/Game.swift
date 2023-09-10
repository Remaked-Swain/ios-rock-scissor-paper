//
//  Game.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

final class Game {
    func doRSP(currentWinner: PlayerType) {
        let userInput = input(currentWinner: currentWinner)
        let userInputType = userInput.showInputType()
        
        guard userInputType == .handSign || userInputType == .invalidInput else {
            print(Script.gameOver)
            return
        }
        
        guard userInputType == .handSign else {
            if currentWinner == .none {
                print(Script.invalidInput)
                return doRSP(currentWinner: .none)
            } else {
                print(Script.noticeCurrentWinner(.computer))
                return doRSP(currentWinner: .computer)
            }
        }
        
        let computerHandSign = generateRandomHandSign()
        let userHandSign = convertToEachHandSign(userInput, currentWinner: currentWinner)
        let gameResult = compareMutualHandSign(computerHandSign: computerHandSign, userHandSign: userHandSign, currentWinner: currentWinner)
        let newWinner = determineWinner(gameResult)
        
        guard currentWinner != .none, newWinner == .none else { return doRSP(currentWinner: newWinner) }
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
    
    private func compareMutualHandSign(computerHandSign computer: HandSign?, userHandSign user: HandSign?, currentWinner: PlayerType) -> GameResult {
        guard let computer = computer, let user = user else { print("비교과정 옵셔널 해제 실패"); return .draw }
        
        let isNextStep: Bool = currentWinner != .none
        
        switch (computer, user) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.win)
            return .win
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.lose)
            return .lose
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            print(Script.draw(currentWinner))
            return .draw
        }
    }
    
    private func determineWinner(_ gameResult: GameResult) -> PlayerType {
        switch gameResult {
        case .win: return .user
        case .lose: return .computer
        case .draw: return .none
        }
    }
}
