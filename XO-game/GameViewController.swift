//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    let session = Session.shared.mode
    
    private let gameboard = Gameboard()
    private var count = 0
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                if self.session == .fiveByFive {
                    delay(0.5) {
                        self.gameboardView.clear()
                        self.gameboard.clear()
                        self.goToNextState()
                    }
                } else {
                    self.count += 1
                    self.goToNextState()
                }
            }
        }
    }
    
    private func goToFirstState() {
        let player = Player.first
        if session == .fiveByFive {
            self.currentState = FiveToFiveState(player: player,
                                                gameViewController: self,
                                                gameBoard: gameboard,
                                                gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
    } else {
        currentState = PlayerState(player: player,
                                   gameViewController: self,
                                   gameBoard: gameboard,
                                   gameBoardView: gameboardView,
                                   markViewPrototype: player.markViewPrototype)
    }
}

    private func checkForGameCompleted() -> Bool {
        return Session.shared.playerFirstMoves.count > 0 && Session.shared.playerSecondMoves.count > 0
    }

private func checkGameEnded() -> Bool {
    if let winner = referee.determineWinner() {
        Log(action: .gameFinished(winner: winner))
        self.currentState = GameEndedState(winner: winner, gameViewController: self)
        return true
    }
    
    if count >= 9 {
        Log(action: .gameFinished(winner: nil))
        currentState = GameEndedState(winner: nil, gameViewController: self)
        return true
    }
    return false
}

    private func goToNextState() {
        
        let playerInputState = currentState as? PlayerState
        let player = playerInputState?.player.next
        
        if session == .fiveByFive && checkForGameCompleted() {
            currentState = GameExecuteState(gameViewController: self,
                                            gameBoard: gameboard,
                                            gameBoardView: gameboardView) { [self] in
                if let winner = referee.determineWinner() {
                    Log(action: .gameFinished(winner: winner))
                    currentState = GameEndedState(winner: winner, gameViewController: self)
                } else {
                    Log(action: .gameFinished(winner: nil))
                    currentState = GameEndedState(winner: nil, gameViewController: self)
                }
            }
            return
        }
        
        if session != .fiveByFive && checkGameEnded() {
            return
        }
        
        if player == .computer {
            delay(0.5) { [self] in
                currentState = Computer(player: player!,
                                        gameViewController: self,
                                        gameBoard: gameboard,
                                        gameBoardView: gameboardView,
                                        markViewPrototype: player!.markViewPrototype)
                count += 1
                goToFirstState()
                _ = checkGameEnded()
                return
            }
        }
        
        if session == .fiveByFive, let playerInputState = currentState as? FiveToFiveState {
            let player = playerInputState.player.next
            currentState = FiveToFiveState(player: player,
                                           gameViewController: self,
                                           gameBoard: gameboard,
                                           gameBoardView: gameboardView,
                                           markViewPrototype: player.markViewPrototype)
        } else if let playerInputState = currentState as? PlayerState {
            let player = playerInputState.player.next
            currentState = PlayerState(player: player,
                                       gameViewController: self,
                                       gameBoard: gameboard,
                                       gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        }
    }


private func configureUI() {
    if session == .againstComputer {
        firstPlayerTurnLabel.text = "Human"
        secondPlayerTurnLabel.text = "Computer"
    }
}

@IBAction func restartButtonTapped(_ sender: UIButton) {
    Log(action: .restartGame)
    gameboardView.clear()
    gameboard.clear()
    goToFirstState()
    Session.shared.playerFirstMoves = []
    Session.shared.playerSecondMoves = []
    count = 0
}
}

func delay(_ delay: Double, closure: @escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}
