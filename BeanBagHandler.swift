//
//  BeanBagHandler.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/2/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import UIKit

class BeanBagHandler {
    
    var blueBags = [BeanBag]()
    var redBags = [BeanBag]()
    var thrownBag: BeanBag?
    var currentBeanBag: BeanBag?
    
    var currentBlue: Int?
    var currentRed: Int?
    
    var redThrowsLeft: Int?
    var blueThrowsLeft: Int?
    
    var beanBagLayer: Int?
    let BOTTOM_LAYER: Int = 10
    
    let FINAL_SCORE: Int = 21
    
    var defaultBlueXPosition : CGFloat = 800
    var defaultRedXPosition : CGFloat = 1120
    
    var board: CornholeBoard?
    

    
    init(cornholeBoard: CornholeBoard){
        board = cornholeBoard
        reset()
        placeCurrentBeanBag()
    }
    
    func reset(){
        resetBags()
        currentBlue = 0
        currentRed = 0
        redThrowsLeft = 5
        blueThrowsLeft = 5
        beanBagLayer = 1
        if(GameManager.gameManager.currentTeam == .BlueTeam){
            currentBeanBag = blueBags[0]
            
        } else {
            currentBeanBag = redBags[0]
            
        }
        placeCurrentBeanBag()

    }
    
    func removeAll() {
        for bag in blueBags {
            bag.removeFromParent()
            bag.removeAllChildren()
        }
        blueBags.removeAll()
    }
    
    func placeCurrentBeanBag() {
        currentBeanBag?.placeBeanBagAtStart()
        currentBeanBag?.zPosition = CGFloat(BOTTOM_LAYER + beanBagLayer!)

    }
    
    func resetBags(){
        blueBags.removeAll()
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", cornholeBoard: board!, xPos: defaultBlueXPosition, yPos: 275, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", cornholeBoard: board!, xPos: defaultBlueXPosition, yPos: 225 , width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", cornholeBoard: board!, xPos: defaultBlueXPosition, yPos: 175, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", cornholeBoard: board!, xPos: defaultBlueXPosition, yPos: 125, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", cornholeBoard: board!, xPos: defaultBlueXPosition, yPos: 75, width: 32, height: 32))
        
        redBags.removeAll()
        redBags.append(BeanBag(spriteTextureName: "RedBag", cornholeBoard: board!, xPos: defaultRedXPosition, yPos: 275, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", cornholeBoard: board!, xPos: defaultRedXPosition, yPos: 225 , width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", cornholeBoard: board!, xPos: defaultRedXPosition, yPos: 175, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", cornholeBoard: board!, xPos: defaultRedXPosition, yPos: 125, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", cornholeBoard: board!, xPos: defaultRedXPosition, yPos: 75, width: 32, height: 32))
    }
    
    func throwBag(tossPower: CGFloat, axisX: CGFloat, screenMidPoint: CGFloat, horizonY: CGFloat) {
        thrownBag = currentBeanBag!
        GameManager.gameManager.gameState = .BagInPlay
        currentBeanBag?.throwBag(tossPower, axisX: axisX, screenMidPoint: screenMidPoint, horizonY: horizonY, completion: { (result) -> Void in
            if(result == true){
                GameManager.gameManager.gameState = .Playing
                if(GameManager.gameManager.currentTeam == CurrentTeam.BlueTeam) {
                    self.currentBlue = self.currentBlue! + 1
                    self.blueThrowsLeft = self.blueThrowsLeft! - 1
                    
                    if(self.redThrowsLeft >= 1){
                        self.currentBeanBag = self.redBags[self.currentRed!]
                    }
                    self.currentBeanBag?.placeBeanBagAtStart()
                    self.currentBeanBag?.zPosition = CGFloat(self.BOTTOM_LAYER + self.beanBagLayer!)
                    
                    self.beanBagLayer = self.beanBagLayer! + 1
                    GameManager.gameManager.currentTeam = CurrentTeam.RedTeam
                    
                } else if(GameManager.gameManager.currentTeam == CurrentTeam.RedTeam) {
                    self.currentRed = self.currentRed! + 1
                    self.redThrowsLeft = self.redThrowsLeft! - 1
                    
                    if(self.blueThrowsLeft >= 1){
                        self.currentBeanBag = self.blueBags[self.currentBlue!]
                    }
                    self.currentBeanBag?.zPosition = CGFloat(self.BOTTOM_LAYER + self.beanBagLayer!)
                    self.beanBagLayer = self.beanBagLayer! + 1
                    
                    self.currentBeanBag?.placeBeanBagAtStart()
                    GameManager.gameManager.currentTeam = CurrentTeam.BlueTeam
                }

            }
            if(self.redThrowsLeft == 0 && self.blueThrowsLeft == 0){
                self.endRound()
            }
        })
        
    }
    
    func endRound(){
        var redScore: Int = 0
        var blueScore: Int = 0

        for bag in redBags {
            switch bag.bagState {
            case .Board:
                redScore = redScore + 1
                break
            case .InHole:
                redScore = redScore + 3
                break
            default:
                break
            }
        }
        
        for bag in blueBags {
            switch bag.bagState {
            case .Board:
                blueScore = blueScore + 1
                break
            case .InHole:
                blueScore = blueScore + 3
                break
            default:
                break
            }
        }
        
        if(blueScore > redScore){
            GameManager.gameManager.blueTeamScore = GameManager.gameManager.blueTeamScore + blueScore - redScore
            GameManager.gameManager.gameState = .RoundEnd
            GameManager.gameManager.currentTeam = .BlueTeam
            GameManager.gameManager.gameMessage = "Blue Team Wins This Round";

            
            if(GameManager.gameManager.blueTeamScore >= FINAL_SCORE) {
                GameManager.gameManager.gameMessage = "Blue Team Wins!"
                GameManager.gameManager.gameState = .GameFinished
            }
        } else if(blueScore < redScore){
            GameManager.gameManager.redTeamScore = GameManager.gameManager.redTeamScore + redScore - blueScore
            GameManager.gameManager.gameState = .RoundEnd
            GameManager.gameManager.currentTeam = .RedTeam
            GameManager.gameManager.gameMessage = "Red Team Wins This Round";


            if(GameManager.gameManager.redTeamScore >= FINAL_SCORE) {
                GameManager.gameManager.gameMessage = "Red Team Wins!"
                GameManager.gameManager.gameState = .GameFinished
            }
        } else {
            GameManager.gameManager.gameState = .RoundEnd
        }
        
        reset()
        
    }
    
    
    
    
}

