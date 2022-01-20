//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation
import UIKit

enum gameMode {
    case againstHuman
    case againstComputer
    case fiveByFive
}

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var twoPlayer: UIButton!
    @IBOutlet weak var computerPlayer: UIButton!
    @IBOutlet weak var fiveToFive: UIButton!
    
    @IBAction func twoPlayerPress(_ sender: Any) {
        Session.shared.mode = .againstHuman
        performSegue(withIdentifier: "goGame", sender: self)
    }
    
    @IBAction func computerPlayerPress(_ sender: Any) {
        Session.shared.mode = .againstComputer
        performSegue(withIdentifier: "goGame", sender: self)
    }
    
    @IBAction func fiveToFivePress(_ sender: Any) {
        Session.shared.mode = .fiveByFive
        performSegue(withIdentifier: "goGame", sender: self)
    }
}
