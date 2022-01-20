//
//  GameEndedState.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 19.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    
    public let isCompleted = false
    
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " выиграл"
        } else {
            self.gameViewController?.winnerLabel.text = "Ничья"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first: return Session.shared.mode == .againstComputer ? "Участник" : "1 игрок"
        case .second: return "2 игрок"
        case .computer: return "Компьютер"
        }
    }
}
