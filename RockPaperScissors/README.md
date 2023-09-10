# 묵찌빠 프로젝트
가위바위보, 묵찌빠 게임을 구현

## **게임 규칙과 순서**
* **가위바위보 게임**
    * 승리 조건
        1. 가위는 보를 이긴다.
        2. 보는 바위를 이긴다.
        3. 바위는 가위를 이긴다.
    
    * 프로그램 흐름
        1. 두 참가자는 각자 가위, 바위, 보 중 하나를 선택한다.
        2. 서로 선택한 것을 승리 조건에 맞춰 비교한다.
        3. 비긴 경우 1~2번을 반복한다.
        4. 승자를 결정한다.
    
* **묵찌빠 게임**
    * 승리 조건
        1. 가위바위보 게임을 진행하여 결정된 승자가 존재해야 한다.
        2. 다시 가위바위보 게임을 진행했을 때 비긴 경우 임시 승자는 최종 승자가 된다.
    
    * 프로그램 흐름
        1. 가위바위보 게임을 진행하고 임시 승자를 결정한다.
        2. 다시 가위바위보 게임을 진행하고 비긴 경우가 나오면 최종 승자를 결정한다.
    
--------------------------------------------------

## **프로젝트 구성**

### **Class folder**

* Entry point - doRSP() method
```swift
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
```

    * Entry Point - doRSP() method
    1. 입력 받기, 입력값 확인, 비교, 승자 결정 순서로 이어지는 가위바위보 게임
> 묵찌빠 게임이라는 것이 결국 가위바위보 게임으로 임시 승자를 정하고, 다시 가위바위보를 해서 확정 승자를 정하는 것이다.
> 따라서 가위바위보 게임을 처음 돌리는 것인지 아닌지를 판단하기 위하여 임시 승자의 존재 유무를 파라미터로 받아 내부에서 체크하도록 하면 어떨까라는 아이디어를 녹여내려고 했다.

* input()
```swift
private func input(currentWinner: PlayerType) -> UserInputModel {
    let emptyString: String = ""
    print(Script.input(currentWinner), terminator: emptyString)
    
    guard let strInput = readLine(), let intInput = Int(strInput), (0...3).contains(intInput) else { return UserInputModel(nil) }
    guard intInput == 0 else { return UserInputModel(intInput) }
    return UserInputModel(0)
}
```

    * input()
    1. 입력을 받기 위한 스크립트 출력
    2. 입력 유효성 검증하고 그에 맞는 UserInputModel을 반환
    
* convertToEachHandSign()
```swift
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
```

    * convertToEachHandSign()
    1. 입력 받은 실질 값을 확인
    2. 가위바위보 단계와 묵찌빠 단계에서는 가위와 바위가 바뀌는 것에 대한 처리
    3. HandSign으로 인식할 수 없는 입력에 대해서 검증
    
* generateRandomHandSign()
```swift
private func generateRandomHandSign() -> HandSign? {
    HandSign.allCases.randomElement()
}
```

    * generateRandomHandSign()
    1. HandSign 중 랜덤한 값을 반환
> 컴퓨터가 가위, 바위, 보 중에서 하나를 선택할 수 있게 한다.

* compareMutualHandSign()
```swift
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
```

    * compareMutualHandSign()
    1. 컴퓨터와 사용자가 낸 손 모양을 비교
    2. 단계별로 다른 스크립트를 출력
    3. 각 손 모양의 상하관계에 따라 게임 결과 반환
> 컴퓨터와 사용자의 손 모양에 대해서 옵셔널 해제에 실패할 경우에 '비김'을 반환하는 것은 논리적으로 이상하다. 어떻게 수정하면 좋을까?

* determineWinner()
```swift
private func determineWinner(_ gameResult: GameResult, currentWinner: PlayerType) -> PlayerType {
    let isNextStep: Bool = currentWinner != .none
    
    switch gameResult {
    case .win: return .user
    case .lose: return .computer
    case .draw: return isNextStep ? .none : currentWinner
    }
}
```

    * determineWinner()
    1. 게임 결과에 따라 임시 승자나 확정 승자가 누구인지 반환
> 가위바위보 단계에서는 .none일 경우 재시작 조건이지만 묵찌빠 단계에서는 .none이 게임 승패를 안내하고 프로그램을 끝내는 조건이다.

* noticeGameStatus()
```swift
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
```

    * noticeGameStatus()
    1. 임시 승자에 따라서 다른 출력물을 내보내기 위한 스위칭
> 시점 별 출력값이 달라야 하는 것 때문에 애를 먹었다.

--------------------------------------------------

### **Models folder**

* HandSign
```swift
@frozen enum HandSign: CaseIterable {
    case rock, scissors, paper
}
```

> 손 모양의 열거

* InputType
```swift
@frozen enum InputType {
    case exitProgram, handSign, invalidInput
}
```

> 사용자가 입력할 수 있는 값의 열거

* GameResult
```swift
@frozen enum GameResult {
    case win, lose, draw
}
```

> 게임의 결과로 나올 수 있는 상태의 열거

* UserInputModel
```swift
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
```

* Script
```swift
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
```

> 프로그램 진행 과정에서 쓰이는 출력물의 열거

* PlayerType
```swift
@frozen enum PlayerType: CustomStringConvertible {
    case computer, user, none
    
    var description: String {
        switch self {
        case .computer: return "컴퓨터"
        case .user: return "사용자"
        case .none: return "없음"
        }
    }
}
```

> 게임 참가자에 대한 열거, `case none`은 임시 승자나 확정 승자가 없을 때 초기값으로 활용
