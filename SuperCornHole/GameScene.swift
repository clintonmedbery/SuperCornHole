//
//  GameScene.swift
//  SuperCornHole
//
//  Created by Clinton Medbery on 11/1/15.
//  Copyright (c) 2015 Programadores Sans Frontieres. All rights reserved.
//

import SpriteKit
import GameController

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var beanBagHandler:BeanBagHandler?
    var backgroundTiler: BackgroundTiler?
    var cornholeBoard: CornholeBoard?
    var hole: Hole?
    var blueBucket: Bucket?
    var redBucket: Bucket?

    
    var isThrowing: Bool = false
    
    var throwX = [Double]()
    var throwY = [Double]()
    var throwZ = [Double]()
    
    
    var gamePad: GCMicroGamepad? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
        cornholeBoard = CornholeBoard(spriteTextureName: "cornholeFrontReg", xPos: UIScreen.mainScreen().bounds.width/2, yPos: (UIScreen.mainScreen().bounds.height/2) + 125, width: 256, height: 320)
        
        addChild(cornholeBoard!)
        
        hole = Hole(spriteTextureName: "hole", xPos: UIScreen.mainScreen().bounds.width/2, yPos: (UIScreen.mainScreen().bounds.height/2) + 235, width: 64, height: 64)
        addChild(hole!)
        backgroundTiler = BackgroundTiler(name: "yard", tileSize: 64)
        for tile in backgroundTiler!.tiles{
            tile.zPosition = -1
            addChild(tile)
        }
        
        blueBucket = Bucket(frontSpriteName: "bucketFront", fullSpriteName: "bucket", width: 64, height: 64, xPos: (UIScreen.mainScreen().bounds.width/2) - 300, yPos: 100)
        redBucket = Bucket(frontSpriteName: "bucketFront", fullSpriteName: "bucket", width: 64, height: 64, xPos: (UIScreen.mainScreen().bounds.width/2) + 300, yPos: 100)
        
        addChild((blueBucket?.full)!)
        addChild((blueBucket?.front)!)

        addChild((redBucket?.full)!)
        addChild((redBucket?.front)!)

        
        beanBagHandler = BeanBagHandler(cornholeBoard: cornholeBoard!)
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
        
        for bag in (beanBagHandler?.blueBags)!{
            if(bag.bagState != BagState.Ground  && bag.bagState != BagState.Air  && hole?.checkForLanding(bag) == true){
                bag.makeBagFall()
            }
        }
        
        for bag in (beanBagHandler?.redBags)!{
            if(bag.bagState != BagState.Ground  && bag.bagState != BagState.Air  && hole?.checkForLanding(bag) == true){
                bag.makeBagFall()
            }
        }
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
                        self.throwBag()
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
            throwX.append(motion.gravity.x)
            throwY.append(motion.gravity.y)
            throwZ.append(motion.gravity.z)
            
        }
    }
    
    func throwBag(){
        var averageX: Double = 0
        var totalX: Double = 0
        
        var averageY: Double = 0
        var totalY: Double = 0
        
        var averageZ: Double = 0
        var totalZ: Double = 0
        
        if(throwX.count < 200){
            
            for x in throwX {
                totalX = totalX + x
            }
            averageX = totalX/Double(throwX.count)
            
            for y in throwY {
                totalY = totalY + y
            }
            averageY = totalY/Double(throwY.count)
            
            for z in throwZ {
                totalZ = totalZ + z
            }
            averageZ = totalZ/Double(throwZ.count)
        }
        print("-------------------")
        print("AVERAGE X")
        print(averageX)
        print("AVERAGE Y")
        print(averageY)
        print("AVERAGE Z")
        print(averageZ)
        print("COUNT")
        print(throwX.count)
        print("-------------------")
        print("")
        
        beanBagHandler?.throwBag(CGFloat(throwX.count))
        
        throwX.removeAll()
        throwY.removeAll()
        throwZ.removeAll()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
      
        
    }
}
