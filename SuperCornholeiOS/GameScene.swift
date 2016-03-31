//
//  GameScene.swift
//  SuperCornholeiOS
//
//  Created by Clinton Medbery on 3/29/16.
//  Copyright (c) 2016 Programadores Sans Frontieres. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
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
    
    var rightSide: CGFloat?
    var leftSide :CGFloat?

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
        readyLabel!.fontSize = 12;
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
        cornholeBoard = CornholeBoard(spriteTextureName: "cornholeFrontReg", xPos: self.frame.size.width/2, yPos: (self.frame.size.height/2) + 50, width: 256, height: 320)
        rightSide = self.frame.midX - cornholeBoard!.size.width/2
        leftSide = self.frame.midX - cornholeBoard!.size.width/2
        print("RIGHT SIDE")
        print(rightSide)
        print("LEFT SIDE")
        
        print(leftSide)
        
        
        
        addChild(cornholeBoard!)
        
        hole = Hole(spriteTextureName: "hole", xPos: cornholeBoard!.position.x, yPos: (cornholeBoard!.position.y) + 100, width: 64, height: 64)
        addChild(hole!)
        backgroundTiler = BackgroundTiler(name: "yard", tileSize: 48)
        for tile in backgroundTiler!.tiles{
            tile.zPosition = -1
            addChild(tile)
        }
        
//        blueBucket = Bucket(frontSpriteName: "bucketFront", fullSpriteName: "bucket", width: 64, height: 64, xPos: (self.view!.bounds.size.width/2) - 20, yPos: 100)
//        redBucket = Bucket(frontSpriteName: "bucketFront", fullSpriteName: "bucket", width: 64, height: 64, xPos: (self.view!.bounds.width/2) + 300, yPos: 100)
//        
//        addChild((blueBucket?.full)!)
//        addChild((blueBucket?.front)!)
        
//        addChild((redBucket?.full)!)
//        addChild((redBucket?.front)!)
        
        
        beanBagHandler = BeanBagHandler(cornholeBoard: cornholeBoard!, defaultBlueXPos: self.frame.midX - 160, defaultRedXPos: self.frame.midX + 160)
        addBags()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            print("Width: \(self.frame.size.width)")
            print("Tap location: \(self.frame.minX)")
            print("Board location: \(cornholeBoard?.position)")
            
            if(GameManager.gameManager.gameState == .Paused) {
                print("UNPAUSED")
                self.pauseTint?.hidden = true
                //self.view!.paused = false
                
                GameManager.gameManager.gameState = GameState.Playing
                
                
            }
            if(GameManager.gameManager.gameState == .NotReady) {
                print("UNPAUSED")
                self.pauseTint?.hidden = true
                self.readyLabel?.hidden = true
                //self.view!.paused = false
                
                GameManager.gameManager.gameState = GameState.Playing
                
                
            }


        }
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
