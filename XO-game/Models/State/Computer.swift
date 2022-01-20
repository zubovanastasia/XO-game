//
//  Computer.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class Computer: GameState {
    
    var isCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?

    public let markViewPrototype: MarkView

    init(player: Player, gameViewController: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }

    func begin() {
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = false
        
        if let position = calculatePosition() {
            addMark(at: position)
        }

        gameViewController?.winnerLabel.isHidden = true
    }

    func addMark(at position: GameboardPosition) {
        Log(action: .playerSetMark(player: player, position: position))

        guard let gameBoardView = gameBoardView,
              gameBoardView.canPlaceMarkView(at: position) else {
            return
        }

        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isCompleted = true
    }
    
    private func calculatePosition() -> GameboardPosition? {
        var positions: [GameboardPosition] = []

        for col in 0...GameboardSize.columns - 1 {
            for row in 0...GameboardSize.rows - 1 {
                let position = GameboardPosition(column: col, row: row)
                if gameBoardView!.canPlaceMarkView(at: position) {
                    positions.append(position)
                }
            }
        }
        
        return positions.randomElement()
    }
}
