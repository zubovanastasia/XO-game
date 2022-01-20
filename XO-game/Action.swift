//
//  Action.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public enum Action {
    
    case playerSetMark(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}
