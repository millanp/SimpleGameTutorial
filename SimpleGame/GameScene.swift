//
//  GameScene.swift
//  SimpleGame
//
//  Created by Millan Philipose on 7/25/16.
//  Copyright (c) 2016 Millan Philipose. All rights reserved.
//

import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func - (right: CGPoint, left: CGPoint) -> CGPoint {
    return CGPoint(x: right.x - left.x, y: right.y - left.y)
}

class GameScene: SKScene {
    let player = SKSpriteNode(imageNamed: "player")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addAttackingMonster),
                SKAction.waitForDuration(1.0)
            ])
        ))
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func addAttackingMonster() {
        let monster = SKSpriteNode(imageNamed: "monster")
        
        // Spawn at a random height within the area where it will be on the screen
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        // Position the monster slightly off the right edge, at the random y-coordinate calculated above
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.moveTo(CGPoint(x: size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
