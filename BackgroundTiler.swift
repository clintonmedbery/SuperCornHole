//
//  BackgroundTiler.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/4/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundTiler {
    
    var backgroundData: BackgroundData = BackgroundData()

    
    var tiles = [Tile]()
    
    init(name: String, tileSize: Int){

        if(name == "yard"){
            
            var currentX: Int = tileSize/2
            var currentY: Int = tileSize/2
            for column in backgroundData.yardBackground {
                for numTile in column {
//                    print(UIScreen.mainScreen().bounds.height)
                    if(numTile == 0){
                        tiles.append(Tile(spriteTextureName: "sky1", xPos: CGFloat(currentX), yPos: CGFloat(currentY), width: tileSize, height: tileSize))
                    } else if(numTile == 1) {
                        tiles.append(Tile(spriteTextureName: "grass1", xPos: CGFloat(currentX), yPos: CGFloat(currentY), width: tileSize, height: tileSize))
                    } else if(numTile == 2) {
                        tiles.append(Tile(spriteTextureName: "grass2", xPos: CGFloat(currentX), yPos: CGFloat(currentY), width: tileSize, height: tileSize))
                    } else if(numTile == 3) {
                        tiles.append(Tile(spriteTextureName: "grass3", xPos: CGFloat(currentX), yPos: CGFloat(currentY), width: tileSize, height: tileSize))
                    } else if(numTile == 4) {
                        tiles.append(Tile(spriteTextureName: "grass4", xPos: CGFloat(currentX), yPos: CGFloat(currentY), width: tileSize, height: tileSize))
                    }
                    
                    UIScreen.mainScreen().bounds.height
                    currentX = currentX + tileSize
                }
                currentX = tileSize/2
                currentY = currentY + tileSize
            }
        }
        
        
    }
    
}