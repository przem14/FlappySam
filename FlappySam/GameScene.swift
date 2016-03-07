//
//  GameScene.swift
//  FlappySam
//
//  Created by Przemysław Wawrzyniak on 07.03.2016.
//  Copyright (c) 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let player = Player()
    var platform: Platform?
    
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            preparePlayerNode()
            preparePlatform()
            contentCreated = true
        }
    }
    
    func preparePlayerNode() {
        let percentageOfWidthForPlayer: CGFloat = 0.2
        let scaleFactor = (frame.width * percentageOfWidthForPlayer) / player.node.frame.width
        
        player.node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        player.node.xScale = scaleFactor
        player.node.yScale = scaleFactor
        addChild(player.node)
    }
    
    func preparePlatform() {
        platform = Platform(width: self.frame.width, factor: 0.1)
        platform!.node.anchorPoint = CGPointMake(0, 0)
        platform!.node.position = CGPointMake(0, 0)
        addChild(platform!.node)
        platform!.node.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveByX(-platform!.node.children[0].frame.width, y: 0, duration: 1),
                SKAction.moveByX(platform!.node.children[0].frame.width, y: 0, duration: 0)])))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
