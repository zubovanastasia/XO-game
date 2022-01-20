//
//  Command.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class Command {
    
    let action: Action
    
    init(action: Action) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case .playerSetMark(let player, let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) won the game"
            } else {
                return "Game is drawn"
            }
        case .restartGame:
            return "Game restarted"
        }
    }
}
