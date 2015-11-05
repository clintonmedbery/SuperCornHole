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
    var currentBeanBag: BeanBag?
    
    var currentBlue: Int?
    var currentRed: Int?
    
    var redThrowsLeft: Int?
    var blueThrowsLeft: Int?
    
    var beanBagLayer: Int?
    let BOTTOM_LAYER: Int = 10
    
    var defaultBlueXPosition : CGFloat = 800
    var defaultRedXPosition : CGFloat = 1120
    

    
    init(){
        reset()
    }
    
    func reset(){
        resetBags()
        currentBeanBag = blueBags[0]
        currentBeanBag?.placeBeanBagAtStart()
        currentBlue = 0
        currentRed = 0
        redThrowsLeft = 5
        blueThrowsLeft = 5
        beanBagLayer = 1
    }
    
    func resetBags(){
        blueBags.removeAll()
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 275, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 225 , width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 175, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 125, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 75, width: 32, height: 32))
        
        redBags.removeAll()
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 275, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 225 , width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 175, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 125, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 75, width: 32, height: 32))
    }
    
    func throwBag(tossPower: CGFloat) {
        
        currentBeanBag?.throwBag(tossPower)
        if(GameManager.gameManager.currentTeam == CurrentTeam.BlueTeam) {
            currentBlue = currentBlue! + 1
            blueThrowsLeft = blueThrowsLeft! - 1
            
            if(redThrowsLeft >= 1){
                currentBeanBag = redBags[currentRed!]
            }
            currentBeanBag?.placeBeanBagAtStart()
            currentBeanBag?.zPosition = CGFloat(BOTTOM_LAYER + beanBagLayer!)
            
            beanBagLayer = beanBagLayer! + 1
            GameManager.gameManager.currentTeam = CurrentTeam.RedTeam
            
        } else if(GameManager.gameManager.currentTeam == CurrentTeam.RedTeam) {
            currentRed = currentRed! + 1
            redThrowsLeft = redThrowsLeft! - 1
            
            if(blueThrowsLeft >= 1){
                currentBeanBag = blueBags[currentBlue!]
            }
            currentBeanBag?.zPosition = CGFloat(BOTTOM_LAYER + beanBagLayer!)
            beanBagLayer = beanBagLayer! + 1
            
            currentBeanBag?.placeBeanBagAtStart()
            GameManager.gameManager.currentTeam = CurrentTeam.BlueTeam
        }
    }
}

