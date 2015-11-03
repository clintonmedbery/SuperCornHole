//
//  BeanBag.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/1/15.
//  Copyright © 2015 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SpriteKit

class BeanBag : SKSpriteNode{


    init(spriteTextureName: String, xPos: CGFloat, yPos: CGFloat, width: Int, height: Int) {
        let imageTexture = SKTexture(imageNamed: spriteTextureName)
        let spriteSize = CGSize(width: width, height: height)
        super.init(texture: imageTexture, color: SKColor.clearColor(), size: spriteSize)
        
        
        let body: SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: spriteSize)
        self.physicsBody = body
        
        body.dynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        self.position.x = xPos
        self.position.y = yPos
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    func setUpBeanBag() {
       

        
    }
    
    func throwBag(impulseAmount: CGFloat){
        
        self.physicsBody?.velocity = CGVectorMake(0,0)
        self.physicsBody?.velocity = CGVectorMake(0, impulseAmount)
        
        
    }
    
}