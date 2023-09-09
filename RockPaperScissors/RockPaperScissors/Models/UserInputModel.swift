//
//  UserInput.swift
//  RockPaperScissors
//
//  Created by Swain Yun on 2023/09/09.
//

import Foundation

struct UserInputModel {
    private let inputType: InputType
    private let value: Int?
    
    init(_ value: Int?) {
        switch value {
        case 0: self.inputType = .exitProgram
        case 1, 2, 3: self.inputType = .handSign
        default: self.inputType = .invalidInput
        }
        self.value = value
    }
    
    func showInputType() -> InputType { inputType }
    func showValue() -> Int? { value }
}
