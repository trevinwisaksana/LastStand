//
//  GameScene.swift
//  LastStand Beta 1
//
//  Created by Trevin Wisaksana on 7/5/16.
//  Copyright (c) 2016 Trevin Wisaksana. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let Enemy: UInt32 = 0x1 << 1
    static let Bullet: UInt32 = 0x1 << 2
    static let Shooter: UInt32 = 0x1 << 3
    static let Wall : UInt32 = 0x1 << 4
}

var shouldShowInstructions = true
var musicStartsAgain = true

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Objects of instructions
//    var leftInstruction = SKSpriteNode(imageNamed: "leftInstruction")
//    var rightInstruction = SKSpriteNode(imageNamed: "rightSide")
//    let instructions = SKSpriteNode(imageNamed: "instructions")
    
    // Objects of LastStand
    var shooterOne = SKSpriteNode(imageNamed: "turret")
    var scoreLabel = SKLabelNode()
    var wall = SKSpriteNode(imageNamed: "wall")
    var progressValue = 200
    var healthBar = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 250, height: 20))
    let instructions = SKSpriteNode(imageNamed: "instructions")
    var backgroundMusic = SKAudioNode()
    let maxHealth: CGFloat = 100
    var currentHealth: CGFloat = 100
    var canPlaceTurret = false
    var highestScore: Int = 0
    var highestScoreLabel: SKLabelNode!
    var alreadyHit: Bool = true
    
    

    var scorePoint: Int = 0 {
        didSet {
            scoreLabel.text = "\(scorePoint)"
            if scorePoint % 10 == 0 {
                if scorePoint == 9 {
                    haltSpawning()
                }
                
                // CHANGE THIS AFTER TESTING
                if scorePoint == 10 {
                    sequenceForSpawning()
                }
                
                if scorePoint == 29 {
                    haltSpawning()
                }
                
                if scorePoint == 30 {
                    hardSpawn()
                }
                
                if scorePoint == 59 {
                    haltSpawning()
                }
                
                if scorePoint == 60 {
                    hardSpawn()
                }
                
                if scorePoint == 89 {
                    haltSpawning()
                }
                
                if scorePoint == 90 {
                    hardSpawn()
                }

            }
        }
    }
    
    func sequenceForSpawning() {
    
        self.canPlaceTurret = false
        
        let warning = SKSpriteNode(imageNamed: "autoTurretInstruction")
        
        // self.haltSpawn() // Could be here and lose haltSpawning action
        
        let wait = SKAction.waitForDuration(4)
        let waitAgain = SKAction.waitForDuration(3)
        
        //            let showSign = SKAction.fadeInWithDuration(1)
        //            let hideSign = SKAction.fadeOutWithDuration(1)
        
        let sign = SKAction.runBlock({
            warning.hidden = false
            warning.anchorPoint.x = 0
            warning.zPosition = -1
            warning.size = CGSize(width: 900, height: self.frame.size.height)
            warning.position = CGPoint(x: self.frame.size.width * 0.30
            , y: self.frame.size.height * 0.55)
            self.addChild(warning)
            self.canPlaceTurret = false
        })
        
        let haltSpawning = SKAction.runBlock({
            self.haltSpawn()
        })
        
        self.runAction(haltSpawning)
        
        let removeSign = SKAction.runBlock({
            self.canPlaceTurret = true
            warning.hidden = true
        })
        
        let startSpawningAgain = SKAction.runBlock({
            self.level2()
        })
        
        let sequence = SKAction.sequence([haltSpawning, sign, waitAgain, removeSign, wait, startSpawningAgain])
        runAction(sequence)

    }
    
    func hardSpawn() {
        
        self.canPlaceTurret = false
        
        let warning = SKSpriteNode(imageNamed: "autoTurretInstruction")
        
        // self.haltSpawn() // Could be here and lose haltSpawning action
        
        let wait = SKAction.waitForDuration(4)
        let waitAgain = SKAction.waitForDuration(3)
        
        //            let showSign = SKAction.fadeInWithDuration(1)
        //            let hideSign = SKAction.fadeOutWithDuration(1)
        
        let sign = SKAction.runBlock({
            warning.hidden = false
            warning.anchorPoint.x = 0
            warning.zPosition = -1
            warning.size = CGSize(width: 900, height: self.frame.size.height)
            warning.position = CGPoint(x: self.frame.size.width * 0.30
                , y: self.frame.size.height * 0.55)
            self.addChild(warning)
            self.canPlaceTurret = false
        })
        
        let haltSpawning = SKAction.runBlock({
            self.haltSpawn()
        })
        
        self.runAction(haltSpawning)
        
        let removeSign = SKAction.runBlock({
            self.canPlaceTurret = true
            warning.hidden = true
        })
        
        let startSpawningAgain = SKAction.runBlock({
            self.level3()
        })
        
        let sequence = SKAction.sequence([haltSpawning, sign, waitAgain, removeSign, wait, startSpawningAgain])
        runAction(sequence)
        
    }
    
    
    
    func haltSpawning() {
        
        let haltSpawning = SKAction.runBlock({
            self.haltSpawn()
        })
        
        self.runAction(haltSpawning)
        
    }

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        if musicStartsAgain == true {
//            
//            if let musicURL = NSBundle.mainBundle().URLForResource("imperialMarch", withExtension: "mp3") {
//                backgroundMusic = SKAudioNode(URL: musicURL)
//                addChild(backgroundMusic)
//                
//            }
//            
//        }
        
        /////////////////////
        /* Setup your scene here */
        //lastScoreLabel = childNodeWithName("//lastScoreLabel") as! SKLabelNode
        
        
        
        /////////////////////
    
        instructions.hidden = true
        
        instructions.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        instructions.size = CGSize(width: frame.size.width, height: 650)
        instructions.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        instructions.zPosition = 100
        addChild(instructions)
        
        if shouldShowInstructions {
            shouldShowInstructions = false
            let instructionSpawn = SKAction.runBlock({
                self.instructions.hidden = false
            })
            let instructionDisapper = SKAction.runBlock({
                self.instructions.hidden = true
            })
            let waitForIt = SKAction.waitForDuration(5)
            let sequenceHere = SKAction.sequence([instructionSpawn, waitForIt, instructionDisapper])
            self.runAction(sequenceHere)
        }
        
        
        
        
        /////////////////////////////
    
        self.physicsWorld.contactDelegate = self
        
        // Healthbar Reference
        healthBar.position = CGPoint(x: 50, y: frame.size.height * 0.8)
        healthBar.zPosition = 4
        healthBar.anchorPoint.x = 0
        self.addChild(healthBar)
        
        // Shooter Reference
        shooterOne.size = CGSize(width: 260, height: 100)
        shooterOne.position = CGPoint(x: 310, y: frame.size.height / 2)
        shooterOne.physicsBody = SKPhysicsBody(rectangleOfSize: shooterOne.size)
        shooterOne.physicsBody?.categoryBitMask = PhysicsCategory.Shooter
        shooterOne.physicsBody?.affectedByGravity = false
        shooterOne.physicsBody?.dynamic = false
        self.addChild(shooterOne)
        
        // Score Lable 
        scoreLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height * 0.8)
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        // Wall Property 
        wall.size = CGSize(width: 150, height: 700)
        wall.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        wall.position = CGPoint(x: 235, y: 375)
        wall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 150, height: 700))
        wall.zPosition = -3
        wall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        wall.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        wall.physicsBody?.affectedByGravity = false
        wall.physicsBody?.allowsRotation = false
        wall.physicsBody?.dynamic = false
        self.addChild(wall)
        
        // Calling creating enemy function which assures that the enemy is spawned randomly every 1 second
        
        let wait = SKAction .waitForDuration(2, withRange: 0.5)
        
        let spawn = SKAction.runBlock({
            self.createEnemy()
        })
        
        let spawning = SKAction.sequence([wait,spawn])
        self.runAction(SKAction.repeatActionForever(spawning), withKey:"spawning")
        
        print("+++++++++++++++")
        
    }

    
    func didBeginContact(contact: SKPhysicsContact) {
        // This part of the code assures that when the body of enemy makes contact with the bullet or if the body of the bullet makes contact with the enemy, it will run the collisionWithBullet function to allow it to delete the enemy
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        if ((firstBody.categoryBitMask == PhysicsCategory.Enemy) && (secondBody.categoryBitMask == PhysicsCategory.Bullet) || (firstBody.categoryBitMask == PhysicsCategory.Bullet) && (secondBody.categoryBitMask == PhysicsCategory.Enemy)) {
            
            collisionWithBullet(firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
            
            scorePoint += 1
            
            // Used to test if the scorePoint works
            print("&&&&&&&&&")
            
            if scorePoint == 13 {
                level2()
                print("$$$$$$$$$$$$$$$$")
            }
            if scorePoint == 33 {
                level3()
            }
            if scorePoint >= 63 {
                let wait = SKAction.waitForDuration(0.3 * Double(scorePoint/10), withRange: 0.1)
                let spawn = SKAction.runBlock({
                    self.createEnemy()
                })
                let spawning = SKAction.sequence([wait,spawn])
                self.runAction(SKAction.repeatActionForever(spawning), withKey:"spawning")
            }
            
        }
            
        if ((firstBody.categoryBitMask == PhysicsCategory.Enemy) && (secondBody.categoryBitMask == PhysicsCategory.Wall) || (firstBody.categoryBitMask == PhysicsCategory.Wall) && (secondBody.categoryBitMask == PhysicsCategory.Enemy)) {
            collisionWithEnemy(firstBody.node as! SKSpriteNode, Enemy: secondBody.node as! SKSpriteNode)
            reduceHealthBar()
        }
        
        scoreLabel.text = String(scorePoint)
       
    }


    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    func level2() {
        let wait = SKAction .waitForDuration(1, withRange: 0.1)
        let spawn = SKAction.runBlock({
            self.createEnemy()
        })
        let spawning = SKAction.sequence([wait,spawn])
        self.runAction(SKAction.repeatActionForever(spawning), withKey:"spawning")
    }
    
    func level3() {
        let wait = SKAction.waitForDuration(0.3 * Double(scorePoint/10), withRange: 0.1)
        let spawn = SKAction.runBlock({
            self.createEnemy()
        })
        let spawning = SKAction.sequence([wait,spawn])
        self.runAction(SKAction.repeatActionForever(spawning), withKey:"spawning")
    }
    
    func haltSpawn() {
         self.removeActionForKey("spawning")
    }
    
    func collisionWithEnemy(Wall: SKSpriteNode, Enemy: SKSpriteNode) {
        Enemy.removeFromParent()
            
        let explosion = SKEmitterNode(fileNamed: "fireEffect.sks")
        explosion?.position = Enemy.position
        addChild(explosion!)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))

        dispatch_after(time, dispatch_get_main_queue()) {
            explosion?.removeFromParent()
        }
        
    }

    func collisionWithBullet(Enemy: SKSpriteNode, Bullet: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "fireEffect.sks")
        addChild(explosion!)
        explosion?.position = Enemy.position
        
        alreadyHit = false
        Enemy.removeFromParent()
        Bullet.removeFromParent()
    
    
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            explosion?.removeFromParent()
        }
    
    
        // Make emitter 
        // add emitter to scene
        // position emitter at enemy position
        // make wait action (time length of emiter)
        // remove action for emitter
        // make sequence of wait and remove
        // run action
        // remove enemy
        // remove bullet
        
        
    }

    
    // If the left half of the screen is touched, the player could drag the character to shoot the target at a desired enemy
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if location.x < size.width / 2 {
                moveTo(y: position.y, location: location)
            }
            
        }
    }
    
    // When touch == true on the right side of the screen, this will run the spawn bullet function
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

        for touch in touches {
            let location = touch.locationInNode(self)
            if location.x > size.width / 2 {
                spawnBullet(shooterOne.position.x + 100, y: shooterOne.position.y)
            } else if location.x < size.width / 2 {
                moveTo(y: position.y, location: location)
            }
            
            if touches.count <= 10 {
                instructions.hidden = true
            }

            // Creates new turret
            if self.canPlaceTurret == true {
                self.createNewTurret(location.x, y: location.y)
                let spawnSound = SKAction.playSoundFileNamed("spawnSound.mp3", waitForCompletion: false)
                self.runAction(spawnSound)
                canPlaceTurret = false
                // run action to get game started again
                return // return ends function here
            } else if self.canPlaceTurret == false {
                
            }
    
        }
    }
    
    func moveTo(y y: CGFloat, location: CGPoint){
        self.shooterOne.position.y = location.y
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
        
    }
    
    // This function generates a random number which is used to make a random y position
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // This function creates the enemy
    func createEnemy() {
        
        let yPos = randomBetweenNumbers(170, secondNum: frame.size.height - 170)
        
        let lightTrail = SKEmitterNode(fileNamed: "lightTrail.sks")
        lightTrail?.zPosition = 5
        let enemy = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 50, height:50))
        enemy.position = CGPoint(x: self.frame.width * 1.1, y: CGFloat(yPos))
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.dynamic = true
        enemy.physicsBody?.allowsRotation = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategory.Enemy
        enemy.physicsBody!.contactTestBitMask = PhysicsCategory.Bullet | PhysicsCategory.Wall
        enemy.physicsBody!.collisionBitMask = PhysicsCategory.Bullet
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(enemy)
        
        let enemySwarm = SKAction.moveTo(CGPoint(x: -50, y: enemy.position.y), duration: 3)
        let actionDone = SKAction.removeFromParent()
        let sequence = SKAction.sequence([enemySwarm, actionDone])
        enemy.runAction(sequence)
        enemy.addChild(lightTrail!)
        
    }
    
    // Function of bullet
    func spawnBullet(x: CGFloat, y: CGFloat) {
       
        let bulletTrail = SKEmitterNode(fileNamed: "bulletSmoke.sks")
        let bullet = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 20, height: 20))
        bullet.zPosition = -5
        bullet.position = CGPoint(x: x, y: y)
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody!.contactTestBitMask = PhysicsCategory.Enemy
        bullet.physicsBody!.collisionBitMask = PhysicsCategory.Enemy
        bullet.physicsBody?.dynamic = true
        bullet.physicsBody?.allowsRotation = false
        bullet.physicsBody?.usesPreciseCollisionDetection = true

        let action = SKAction.moveToX(self.size.width + 30, duration: 0.6)
        let shotSoundEffect = SKAction.playSoundFileNamed("gunshot.mp3", waitForCompletion: false)
        
        let actionDone = SKAction.removeFromParent()
       bullet.runAction(SKAction.sequence([shotSoundEffect, action, actionDone]))
//        bullet.addChild(bulletTrail!)
        self.addChild(bullet)
        
        print("==============")
        
    }
    
    
    
    func reduceHealthBar(){
        if currentHealth > 0 {
            currentHealth -= 25
            let healthBarReduce = SKAction.scaleXTo(currentHealth / maxHealth, duration: 0.5)
            healthBar.runAction(healthBarReduce)
        } else if currentHealth == 0 {
            
            currentHealth = 0
            runAction(SKAction.sequence([
                SKAction.waitForDuration(0),
                SKAction.runBlock() {
                    // 5
                    let reveal = SKTransition.fadeWithColor(SKColor.whiteColor(), duration: 1)
                    let scene = GameOverScene(size: self.size, won: false)
                    scene.scaleMode = .AspectFill
                    self.view?.presentScene(scene, transition:reveal)
                }
                ]))
            }
        }

    
    func createNewTurret(x: CGFloat, y: CGFloat) {
        print(">>>>> Create Turret <<<<<")
        
        if canPlaceTurret == true {
          
//            let newTurret = SKSpriteNode(color: SKColor.darkGrayColor(), size: CGSize(width: 50, height: 50))
            let newTurret = SKSpriteNode(imageNamed: "autoTurret")
            newTurret.size = CGSize(width: 75, height: 50)
            newTurret.zPosition = 1
            newTurret.position = CGPoint(x: x, y: y)
            let shoot = SKAction.runBlock({
                self.spawnBullet(newTurret.position.x, y: newTurret.position.y)
            })
            
            let wait = SKAction.waitForDuration(2)
            let seq = SKAction.sequence([shoot, wait])
            let forEvah = SKAction.repeatActionForever(seq)
            newTurret.runAction(forEvah)
            
            addChild(newTurret)
        
            
            print("%%%%%%%%%%%%%%")
            
        }
    }
}

