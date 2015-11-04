//
//  GameManager.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/3/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation

class GameManager {
    static let gameManager = GameManager()
    var blueTeamScore: Int = 0
    var redTeamScore: Int = 0
    
    let WINNING_SCORE = 21
    
    private init() {
        
    }
    
    func resetGame() {
        blueTeamScore = 0
        redTeamScore = 0
    }
    
    
}