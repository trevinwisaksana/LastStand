//
//  GameOverScene.swift
//  LastStand Beta 1
//
//  Created by Trevin Wisaksana on 7/6/16.
//  Copyright © 2016 Trevin Wisaksana. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var restartButton = MSButtonNode(imageNamed: "restartButton")
    var restartBackground = SKSpriteNode(imageNamed: "restartBackground")
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        backgroundColor = SKColor.blackColor()
        
        // Button property
        restartButton.size = CGSize(width: 275, height: 275)
        restartButton.position = CGPoint(x: frame.size.width * 0.715, y: frame.size.height * 0.64)
        restartButton.zPosition = 100
        addChild(restartButton)
        
        // Background Property
        restartBackground.position = CGPoint(x: -100, y: frame.size.height / 2)
        restartBackground.size = CGSize(width: 1150, height: 600)
        restartBackground.anchorPoint.x = 0
        addChild(restartBackground)
        
        //HighScore
//        let defaults = NSUserDefaults.standardUserDefaults()
//        menuHighScoreValue = defaults.integerForKey(gameoverState.highScoreKey)
//        menuScoreLabel.text = NSString(format: "High Score : %i", menuHighScoreValue) as String
//        
        // Allows the restartButton to execute these functions when the button is tapped
        restartButton.selectedHandler = {
            let reveal = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.5)
            let scene = GameScene(size: self.size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition:reveal)
            
            
        }
        
        restartButton.state = .Active

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}