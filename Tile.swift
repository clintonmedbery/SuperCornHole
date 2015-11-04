//
//  Tile.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/4/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SpriteKit

class Tile :SKSpriteNode {
    
    init(spriteTextureName: String, xPos: CGFloat, yPos: CGFloat, width: Int, height: Int) {
        let imageTexture = SKTexture(imageNamed: spriteTextureName)
        let spriteSize = CGSize(width: width, height: height)
        super.init(texture: imageTexture, color: SKColor.clearColor(), size: spriteSize)
        
        self.position.x = xPos
        self.position.y = yPos
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}