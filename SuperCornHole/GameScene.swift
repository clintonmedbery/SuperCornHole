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
    var allBags = [BeanBag]()
    
    var isThrowing: Bool = false
    
    var motionReadings = [MotionReading]()
    

    
    var readyLabel: SKLabelNode?
    var pauseTint: SKSpriteNode?
    
    var blueScoreLabel: SKLabelNode?
    var redScoreLabel: SKLabelNode?

    
    var gamePad: GCMicroGamepad? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        pauseTint = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 2000, height: 1100))
        pauseTint?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        pauseTint?.zPosition = 29
        pauseTint?.alpha = 0.7
        addChild(pauseTint!)
        
        readyLabel = SKLabelNode(fontNamed:"Menlo")
        GameManager.gameManager.gameMessage = "Press Play to Start!"
        readyLabel!.text = GameManager.gameManager.gameMessage;
        readyLabel!.fontSize = 65;
        readyLabel!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        readyLabel!.zPosition = 30
        
        let blueColor = UIColor(
            red:2.0,
            green:45.0,
            blue:179.0,
            alpha:1.0)
        
        let redColor = UIColor(
            red:252.0,
            green:0.0,
            blue:9.0,
            alpha:1.0)
        
        blueScoreLabel = SKLabelNode(fontNamed:"Menlo")
        blueScoreLabel!.fontColor = UIColor.blueColor()
        blueScoreLabel!.text = "00";
        blueScoreLabel!.fontSize = 60;
        blueScoreLabel!.position = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:CGRectGetMinY(self.frame) + 100)
        blueScoreLabel!.zPosition = 28
        
        redScoreLabel = SKLabelNode(fontNamed:"Menlo")
        redScoreLabel?.fontColor = UIColor.redColor()
        redScoreLabel!.text = "00";
        redScoreLabel!.fontSize = 60;
        redScoreLabel!.position = CGPoint(x:CGRectGetMaxX(self.frame) - 100, y:CGRectGetMinY(self.frame) + 100)
        redScoreLabel!.zPosition = 28

        self.addChild(redScoreLabel!)
        self.addChild(blueScoreLabel!)
        self.addChild(readyLabel!)
        
        GameManager.gameManager.gameState = .NotReady
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
        addBags()
        
        //beanBagHandler?.blueBags[1].throwBag(50)
        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: Selector("gameControllerDidConnect:"),
                name: GCControllerDidConnectNotification,
                object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("gameControllerDidDisconnect:"),
            name: GCControllerDidDisconnectNotification,
            object: nil)
        
//        print("Gravity X,Gravity Y,Gravity Z,Acceleration X,Acceleration Y,Acceleration Z,Quaternion W,Quaternion X,Quaternion Y,Quaternion Z")

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
        
        redScoreLabel!.text = String(GameManager.gameManager.redTeamScore)
        blueScoreLabel!.text = String(GameManager.gameManager.blueTeamScore)
        
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
        
        if(GameManager.gameManager.gameState == .RoundEnd){
//            print("End Round")
            readyLabel!.text = GameManager.gameManager.gameMessage;

            self.readyLabel?.hidden = false
            self.pauseTint?.hidden = false
            clearBags()
            
            
            beanBagHandler!.reset()
            addBags()
            
            GameManager.gameManager.gameState = .NotReady
//            print(GameManager.gameManager.blueTeamScore)
//            print(GameManager.gameManager.redTeamScore)

        }
        
        if(GameManager.gameManager.gameState == .GameFinished){
            print("End Game")
            readyLabel!.text = GameManager.gameManager.gameMessage;
            
            self.readyLabel?.hidden = false
            self.pauseTint?.hidden = false
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
                    
//                    print("\(buttonA)")
                    if(buttonA.pressed == true && GameManager.gameManager.gameState == .Playing){
//                        print("--------Throwing----------")
//                        print("")
                        self.isThrowing = true
                    } else if(buttonA.pressed == false && GameManager.gameManager.gameState == .Playing) {
//                        print("--------Finished Throwing----------")
//                        print("")
                        self.isThrowing = false
                        self.throwBag()
                    }
                    
                   
                    
                    
                }
                
                gamePad!.buttonX.valueChangedHandler = { (buttonX: GCControllerButtonInput, value:Float, pressed:Bool) -> Void in
                    
//                    print("\(buttonX)")
                    
                    if(buttonX.pressed == true){
                        if(GameManager.gameManager.gameState == .Playing) {
                            print("PAUSED")
                            self.pauseTint?.hidden = false
                            //self.view!.paused = true
                            GameManager.gameManager.gameState = GameState.Paused
                            
                        } else if(GameManager.gameManager.gameState == .Paused) {
                            print("UNPAUSED")
                            self.pauseTint?.hidden = true
                            //self.view!.paused = false
                            
                            GameManager.gameManager.gameState = GameState.Playing


                        }
                    }
                    
                    if(buttonX.pressed == true && GameManager.gameManager.gameState == .NotReady){
                        self.readyLabel?.hidden = true
                        self.pauseTint?.hidden = true
                        GameManager.gameManager.gameState = .Playing

                    }
                    
                    if(buttonX.pressed == true && GameManager.gameManager.gameState == .GameFinished){
                        self.readyLabel?.hidden = true
                        self.pauseTint?.hidden = true
                        GameManager.gameManager.resetGame()
                        self.clearBags()
                        
                        self.beanBagHandler!.reset()
                        self.addBags()
                        GameManager.gameManager.gameState = .Playing
                        
                    }
                    
                }
                
                
                
                controller.motion?.valueChangedHandler = self.controllerMoving
            }
            
        }
    }
    
    func controllerMoving(motion: GCMotion) {
        if(isThrowing == true) {
            
           
            let reading: MotionReading = MotionReading(gravityX: motion.gravity.x, gravityY: motion.gravity.y, gravityZ: motion.gravity.z, accelerationX: motion.userAcceleration.x, accelerationY: motion.userAcceleration.y, accelerationZ: motion.userAcceleration.z)
//            print("")
//            print("")
//
//            reading.printHeader()
//            print(motion.gravity.x)
//            print(motion.gravity.y)
//            print(motion.gravity.z)
//            print(motion.userAcceleration.x)
//            print(motion.userAcceleration.y)
//            print(motion.userAcceleration.z)
//
//            reading.printReadingCSV()
//            print("")
//            print("")
            motionReadings.append(reading)

            
        }
    }
    
    func throwBag(){
        var gravityAverageX: Double = 0
        var gravityAverageY: Double = 0
        var gravityAverageZ: Double = 0
        var accelerationAverageX: Double = 0
        var accelerationAverageY: Double = 0
        var accelerationAverageZ: Double = 0
        
        var gravityTotalX: Double = 0
        var gravityTotalY: Double = 0
        var gravityTotalZ: Double = 0
        var accelerationTotalX: Double = 0
        var accelerationTotalY: Double = 0
        var accelerationTotalZ: Double = 0
        
        var highGravityX: Double = -100.0
        var highGravityY: Double = -1000.0
        var highGravityZ: Double = -1000.0
        
        var lowGravityX: Double = 100.0
        var lowGravityY: Double = 100.0
        var lowGravityZ: Double = 100.0

        
        var averageReading: MotionReading?
        
        print("MOTION READINGS COUNT")
        print(motionReadings.count)
        
        if(motionReadings.count < 200){
           
            
            
            for reading in motionReadings {
                gravityTotalX = gravityTotalX + reading.gravity.x
                gravityTotalY = gravityTotalY + reading.gravity.y
                gravityTotalZ = gravityTotalZ + reading.gravity.z
                
                accelerationTotalX = accelerationTotalX + reading.acceleration.x
                accelerationTotalY = accelerationTotalY + reading.acceleration.y
                accelerationTotalZ = accelerationTotalZ + reading.acceleration.z
                
                if(reading.gravity.x < lowGravityX){
                    lowGravityX = reading.gravity.x
                    
                }
                
                if(reading.gravity.y < lowGravityY){
                    lowGravityY = reading.gravity.y
                    
                }
                
                if(reading.gravity.z < lowGravityZ){
                    lowGravityZ = reading.gravity.z
                    
                }
                
                if(reading.gravity.x > highGravityX){
                    highGravityX = reading.gravity.x
                    
                }
                
                if(reading.gravity.y > highGravityY){
                    highGravityY = reading.gravity.y
                    
                }
                
                if(reading.gravity.z > highGravityZ){
                    highGravityZ = reading.gravity.z
                    
                }
            }
            
            gravityAverageX = (gravityTotalX / Double(motionReadings.count))
            gravityAverageY = (gravityTotalY / Double(motionReadings.count))
            gravityAverageZ = (gravityTotalZ / Double(motionReadings.count))
            
            accelerationAverageX = (accelerationTotalX / Double(motionReadings.count))
            accelerationAverageY = (accelerationTotalY / Double(motionReadings.count))
            accelerationAverageZ = (accelerationTotalZ / Double(motionReadings.count))
            
            
            averageReading = MotionReading(gravityX: gravityAverageX, gravityY: gravityAverageY, gravityZ: gravityAverageZ, accelerationX: accelerationAverageX, accelerationY: accelerationAverageY, accelerationZ: accelerationAverageZ)
//            print("")
//            print("")
//            print("")
//            print("Low Gravity X: \(lowGravityX)")
//            print("High Gravity X: \(highGravityX)")
//            print("Low Gravity Y: \(lowGravityY)")
//            print("High Gravity Y: \(highGravityY)")
//            print("Low Gravity Z: \(lowGravityZ)")
//            print("High Gravity Z: \(highGravityZ)")
//            averageReading?.printReading()
//            print("")
//            print("")
//            print("")

        }
        
        
        
        if(lowGravityX != 100.0 && averageReading!.gravity.y > 0){
            let horizonY: CGFloat = CGRectGetMaxY(self.frame)
            
            
            beanBagHandler?.throwBag(CGFloat(averageReading!.gravity.y), axisX: CGFloat(averageReading!.acceleration.x), screenMidPoint: CGRectGetMidX(self.frame), horizonY: horizonY)

        }
        motionReadings.removeAll()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
      
        
    }
    
    func addBags(){
        for bag in (beanBagHandler?.blueBags)! {
            allBags.append(bag)
            //addChild(bag)
        }
        
        for bag in (beanBagHandler?.redBags)! {
            allBags.append(bag)
            
            //addChild(bag)
        }
        
        for bag in allBags{
            addChild(bag)
        }

    }
    
    func clearBags() {
        for bag in allBags {
            bag.removeFromParent()
        }
        allBags.removeAll()
    }
}
