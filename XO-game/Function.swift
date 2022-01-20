//
//  Function.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public func Log(action: Action) {
    
    let command = Command(action: action)
    Invoker.shared.addLogCommand(command: command)
}
