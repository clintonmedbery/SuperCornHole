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
    var currentTeam: CurrentTeam?
    var gameState: GameState?
    
    
    let WINNING_SCORE = 21
    
    private init() {
        resetGame()
        
    }
    
    func resetGame() {
        blueTeamScore = 0
        redTeamScore = 0
        currentTeam = CurrentTeam.BlueTeam
        gameState = GameState.NotReady
        
    }
    
    
}

enum CurrentTeam {
    case BlueTeam, RedTeam
}

enum GameState {
    case NotReady, Playing, Paused
}