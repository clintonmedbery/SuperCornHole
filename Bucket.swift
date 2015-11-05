//
//  Bucket.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/5/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SpriteKit

class Bucket {
    var front: SKSpriteNode?
    var full: SKSpriteNode?
    
    init(frontSpriteName: String, fullSpriteName: String, width: Int, height: Int, xPos: CGFloat, yPos: CGFloat) {
        let frontTexture = SKTexture(imageNamed: frontSpriteName)
        let fullTexture = SKTexture(imageNamed: fullSpriteName)
        let spriteSize = CGSize(width: width, height: height)
        
        front = SKSpriteNode(texture: frontTexture, size: spriteSize)
        full = SKSpriteNode(texture: fullTexture, size: spriteSize)
        
        
        
        front!.position.x = xPos
        front!.position.y = yPos
        front!.zPosition = 20
        
        full!.position.x = xPos
        full!.position.y = yPos
        full!.zPosition = 8

    }
}