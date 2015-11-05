//
//  GameScene.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/1/15.
//  Copyright (c) 2015 Programadores Sans Frontieres. All rights reserved.
//

import SpriteKit
import GameController

class GameScene: SKScene {
    
    var beanBagHandler:BeanBagHandler?
    var backgroundTiler: BackgroundTiler?
    
    var isThrowing: Bool = false
    
    
    var gamePad: GCMicroGamepad? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        
        backgroundTiler = BackgroundTiler(name: "yard", tileSize: 64)
        for tile in backgroundTiler!.tiles{
            tile.zPosition = -1
            addChild(tile)
        }
        
        beanBagHandler = BeanBagHandler()
        for bag in (beanBagHandler?.blueBags)! {
            addChild(bag)
        }
        
        for bag in (beanBagHandler?.redBags)! {
            addChild(bag)
        }
        //beanBagHandler?.blueBags[1].throwBag(50)
        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: Selector("gameControllerDidConnect:"),
                name: GCControllerDidConnectNotification,
                object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("gameControllerDidDisconnect:"),
            name: GCControllerDidDisconnectNotification,
            object: nil)
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
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
   
    func gameControllerDidConnect(notification : NSNotification) {
        
        if let controller = notification.object as? GCController {
            
            if let mGPad = controller.microGamepad {
                
                // Some setup
                gamePad = mGPad
                gamePad!.allowsRotation = true
                gamePad!.reportsAbsoluteDpadValues = true
                
                print("MicroGamePad connected...")
                
                // Add valueChangedHandler for each control element
//                gamePad!.dpad.valueChangedHandler = { (dpad: GCControllerDirectionPad, xValue: Float, yValue: Float) -> Void in
//                    
//                    print("dpad xValue = \(xValue), yValue = \(yValue)")
//                    
//                    
//                }
                
                gamePad!.buttonA.valueChangedHandler = { (buttonA: GCControllerButtonInput, value:Float, pressed:Bool) -> Void in
                    
                    print("\(buttonA)")
                    if(buttonA.pressed == true){
                        print("------------------")
                        print("")
                        self.isThrowing = true
                    } else if(buttonA.pressed == false) {
                        self.isThrowing = false
                    }
                    
                    
                }
                
                gamePad!.buttonX.valueChangedHandler = { (buttonX: GCControllerButtonInput, value:Float, pressed:Bool) -> Void in
                    
                    print("\(buttonX)")
                    
                    
                }
                
                controller.motion?.valueChangedHandler = self.controllerMoving
            }
            
        }
    }
    
    func controllerMoving(motion: GCMotion) {
        if(isThrowing == true) {
            print(motion.gravity)
            
        }
    }
}
