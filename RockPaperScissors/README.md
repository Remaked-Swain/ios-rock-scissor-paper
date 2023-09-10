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
```

    **Entry Point - doRSP() method**
    1. 입력 받기, 입력값 확인, 비교, 승자 결정 순서로 이어지는 가위바위보 게임
> 묵찌빠 게임이라는 것이 결국 가위바위보 게임으로 임시 승자를 정하고, 다시 가위바위보를 해서 확정 승자를 정하는 것이다.
> 따라서 가위바위보 게임을 처음 돌리는 것인지 아닌지를 판단하기 위하여 임시 승자의 존재 유무를 파라미터로 받아 내부에서 체크하도록 하면 어떨까라는 아이디어를 녹여내려고 했다.

* **
