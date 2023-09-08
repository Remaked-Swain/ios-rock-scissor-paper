//
//  HandSignModel.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/08.
//

import Foundation

@frozen enum HandSign {
    case rock
    case scissors
    case paper
    
    func compareWithGivenHandSign(_ target: HandSign, with handSign: HandSign) -> GameResult {
        switch (target, handSign) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): return .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): return .draw
        default: return .lose
        }
    }
}
