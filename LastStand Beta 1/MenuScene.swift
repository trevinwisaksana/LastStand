//
//  MenuScene.swift
//  LastStand Beta 1
//
//  Created by Trevin Wisaksana on 7/6/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var playButton: MSButtonNode!
//    var instructions = SKLabelNode(fontNamed: "Helvetica")
    var title = SKSpriteNode(imageNamed: "title")
    var decoration = SKSpriteNode(imageNamed: "decoration")
//    let backgroundMusic = SKAction.playSoundFileNamed("backgroundMusic.mp3", waitForCompletion: false)
    var backgroundMusic = SKAudioNode()
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.blackColor()
        
        if let musicURL = NSBundle.mainBundle().URLForResource("backgroundMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(URL: musicURL)
            addChild(backgroundMusic)
        }
        
//        // Instruction Label properties
//        instructions.position = CGPoint(x: frame.size.width / 2, y: frame.size.height * 0.17)
//        instructions.text = "Tap the right side of the screen to shoot, slide the blue square up and down to shoot at the enemy"
//        instructions.fontSize = 20
//        instructions.fontColor = SKColor.whiteColor()
//        addChild(instructions)
        
        // Title label properties
        title.position = CGPoint(x: 200, y: frame.size.height * 0.75)
        title.size = CGSize(width: 250, height: 50)
        addChild(title)
        
        // Play button properties
//        playButton = MSButtonNode(color: SKColor.redColor(), size: CGSize(width: 500, height: 100))
        playButton = MSButtonNode(imageNamed: "playButton")
        playButton.size = CGSize(width: 275, height: 275)
        playButton.zPosition = 100
        playButton.position = CGPoint(x: frame.size.width * 0.715, y: frame.size.height * 0.64)
        addChild(playButton)
        
        // Decoration properties 
        decoration.position = CGPoint(x: -100, y: frame.size.height / 2)
        decoration.size = CGSize(width: 1150, height: 600)
        decoration.anchorPoint.x = 0
        addChild(decoration)
        
        // When play button is tapped, the scene changes to GameScene
        playButton.selectedHandler = {
            
            let scene = GameScene(size: self.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene)
            
        }
        
        playButton.state = .Active
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }    
}
