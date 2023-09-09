//
//  Game.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

final class Game {
    private let emptyString: String = ""
    
    func run() {
        var currentWinner: PlayerType = .none
        currentWinner = doRSP(currentWinner: currentWinner)
        
        guard currentWinner != .none else { return }
        
        currentWinner = doRSP(currentWinner: currentWinner)
        
        guard currentWinner != .none else { return currentWinner = doRSP(currentWinner: currentWinner) }
        return
    }
}

// MARK: RSP Game Logic
extension Game {
    private func doRSP(currentWinner: PlayerType) -> PlayerType {
        var currentWinner = currentWinner
        let userInput = input(currentWinner: currentWinner)
        let userInputType = userInput.showInputType()
        
        guard userInputType == .handSign || userInputType == .invalidInput else {
            print(Script.gameOver)
            return .none
        }
        
        guard userInputType == .handSign else {
            if currentWinner != .none {
                currentWinner = changeTurn(currentWinner: currentWinner)
            } else {
                print(Script.invalidInput)
            }
            
            return doRSP(currentWinner: currentWinner)
        }
        
        let userHandSign = convertToEachHandSign(userInput, currentWinner: currentWinner)
        let computerHandSign = generateRandomHandSign()
        test(computerHandSign, userHandSign)
        
        guard let gameResult = compareMutualHandSign(computerHandSign: computerHandSign, userHandSign: userHandSign, currentWinner: currentWinner) else { return doRSP(currentWinner: currentWinner) }
        let winner = determineWinner(gameResult)
        
        return winner
    }
    
    private func test(_ computerHandSign: HandSign?, _ userHandSign: HandSign?) {
        guard let computerHandSign = computerHandSign, let userHandSign = userHandSign else { return }
        let com = test2(computerHandSign); let user = test2(userHandSign)
        print("-----System-----\n컴퓨터: \(com)\n사용자: \(user)\n-----------------")
    }
    
    private func test2(_ handSign: HandSign) -> String {
        switch handSign {
        case .paper: return "보"
        case .rock: return "바위"
        case .scissors: return "가위"
        }
    }
}

// MARK: Resuable Methods
extension Game {
    private func input(currentWinner: PlayerType) -> UserInputModel {
        print(Script.input(currentWinner), terminator: emptyString)
        
        guard let input = readLine(), let intInput = Int(input) else { return UserInputModel(nil) }
        
        switch intInput {
        case 0: return UserInputModel(0)
        case 1, 2, 3: return UserInputModel(intInput)
        default: return UserInputModel(nil)
        }
    }
    
    private func convertToEachHandSign(_ userInput: UserInputModel, currentWinner: PlayerType) -> HandSign? {
        guard userInput.showInputType() == .handSign, let value = userInput.showValue() else { return nil }
        
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
    
    private func compareMutualHandSign(computerHandSign: HandSign?, userHandSign: HandSign?, currentWinner: PlayerType) -> GameResult? {
        guard let computerHandSign = computerHandSign, let userHandSign = userHandSign else { return nil }
        
        let isNextStep: Bool = currentWinner != .none
        
        switch (computerHandSign, userHandSign) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.win(currentWinner))
            return .win
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            print(isNextStep ? Script.noticeCurrentWinner(currentWinner) : Script.lose)
            return .lose
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            print(Script.draw)
            return isNextStep ? currentWinner == .user ? .win : .lose : .draw
        }
    }
    
    private func determineWinner(_ gameResult: GameResult) -> PlayerType {
        switch gameResult {
        case .win: return .user
        case .lose: return .computer
        case .draw: return .none
        }
    }
    
    private func changeTurn(currentWinner: PlayerType) -> PlayerType {
        currentWinner == .computer ? .user : .computer
    }
}
