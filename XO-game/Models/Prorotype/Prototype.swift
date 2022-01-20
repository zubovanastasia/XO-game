//
//  Prototype.swift
//  XO-game
//
//  Created by Anastasiia Zubova on 20.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Prototype {
     init(_ prototype: Self)
 }

 extension Prototype {
     func copy() -> Self {
         return type(of: self).init(self)
     }
 }
