//
//  CornholeBoard.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/5/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SpriteKit

class CornholeBoard: SKSpriteNode {
    
    init(spriteTextureName: String, xPos: CGFloat, yPos: CGFloat, width: Int, height: Int) {
        
        let imageTexture = SKTexture(imageNamed: spriteTextureName)
        let spriteSize = CGSize(width: width, height: height)
        super.init(texture: imageTexture, color: SKColor.clearColor(), size: spriteSize)
        
        
        let body: SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: spriteSize)
        //self.physicsBody = body
        
        body.dynamic = true
        body.categoryBitMask = PhysicsCategory.Board
        body.affectedByGravity = false
        body.allowsRotation = false
        body.usesPreciseCollisionDetection = true
        
        self.position.x = xPos
        self.position.y = yPos
        self.zPosition = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func checkForLanding(beanBag: BeanBag) -> Bool {
        print("CHECKING")
        if(self.containsPoint(beanBag.position)){
            return true
        }
        return false
    }
    
}