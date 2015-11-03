//
//  GameScene.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/1/15.
//  Copyright (c) 2015 Programadores Sans Frontieres. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var beanBagHandler:BeanBagHandler?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        beanBagHandler = BeanBagHandler()
        for bag in (beanBagHandler?.blueBags)! {
            addChild(bag)
        }
        
        for bag in (beanBagHandler?.redBags)! {
            addChild(bag)
        }
        //beanBagHandler?.blueBags[1].throwBag(50)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
