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
    
    var defaultBlueXPosition : CGFloat = 800
    var defaultRedXPosition : CGFloat = 1120

    
    init(){
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 275, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 225 , width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 175, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 125, width: 32, height: 32))
        blueBags.append(BeanBag(spriteTextureName: "BlueBag", xPos: defaultBlueXPosition, yPos: 75, width: 32, height: 32))
        
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 275, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 225 , width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 175, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 125, width: 32, height: 32))
        redBags.append(BeanBag(spriteTextureName: "RedBag", xPos: defaultRedXPosition, yPos: 75, width: 32, height: 32))



    }
}