//
//  Session.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class Session {
    
    static let shared = Session()
    private init() {}
    
    var mode: gameMode?
    
    var playerFirstMoves: [PlayerMove] = []
    var playerSecondMoves: [PlayerMove] = []
}
