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

    
    func throwBag(impulseAmount: CGFloat){
        

        let landingY: CGFloat = impulseAmount * 10.0
        let point: CGPoint = CGPoint(x: self.position.x, y: self.position.y + landingY)
        
        let moveAction:SKAction = SKAction.moveTo(point, duration: 2)
        let scaleAction: SKAction = SKAction.scaleBy(2, duration: 1.0)
        let rotateAction: SKAction = SKAction.rotateByAngle((impulseAmount * 10), duration: 2.0)
        
        moveAction.timingMode = .EaseOut
        scaleAction.timingMode = .EaseIn
        
        self.runAction(rotateAction)
        self.runAction(moveAction)
        self.runAction(scaleAction) { () -> Void in
            let scaleBackAction: SKAction = SKAction.scaleBy(0.25, duration: 1.0)
            scaleAction.timingMode = .EaseOut
            self.runAction(scaleBackAction)

        }
        
        
    }
    
    func placeBeanBagAtStart(){
        self.position.y = 16
        self.position.x = 1000
        self.setScale(2)
    }
    
}