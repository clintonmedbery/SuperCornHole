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
    var board: CornholeBoard?
    var bagState: BagState = BagState.Bucket

    init(spriteTextureName: String, cornholeBoard: CornholeBoard, xPos: CGFloat, yPos: CGFloat, width: Int, height: Int) {
        board = cornholeBoard
        let imageTexture = SKTexture(imageNamed: spriteTextureName)
        let spriteSize = CGSize(width: width, height: height)
        super.init(texture: imageTexture, color: SKColor.clearColor(), size: spriteSize)
        
        
        let body: SKPhysicsBody = SKPhysicsBody(texture: imageTexture, size: spriteSize)
        self.physicsBody = body
        
        body.dynamic = true
        body.categoryBitMask = PhysicsCategory.BeanBag
        body.contactTestBitMask = PhysicsCategory.Board
        body.affectedByGravity = false
        body.allowsRotation = false
        body.usesPreciseCollisionDetection = true

        self.position.x = xPos
        self.position.y = yPos
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func throwBag(impulseAmount: CGFloat, completion: (result: Bool) -> Void) {
        bagState = BagState.Air
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
            self.runAction(scaleBackAction) { () -> Void in
                print(self.board?.checkForLanding(self))
                if(self.board?.checkForLanding(self) == true) {
                    self.bagState = BagState.Board
                    let point: CGPoint = CGPoint(x: self.position.x, y: self.position.y + impulseAmount)
                    
                    let slideAction:SKAction = SKAction.moveTo(point, duration: 0.25)
                    self.runAction(slideAction) { () -> Void in
                        completion(result: true)

                    }

                } else {
                    self.bagState = BagState.Ground
                    completion(result: true)

                }
            }

        }
        
        
    }
    
    func placeBeanBagAtStart(){
        self.position.y = 16
        self.position.x = 950
        self.setScale(2)
    }
    
    func makeBagFall(){
        self.setScale(0)
        bagState = .InHole
        GameManager.gameManager.gameState = .Playing
    }
    
}

struct PhysicsCategory {
    
    static let Board: UInt32 = 0
    static let BeanBag: UInt32 = 1
    static let Hole: UInt32 = 2
}

enum BagState: Equatable{
    case Bucket, Air, Board, Ground, InHole
}