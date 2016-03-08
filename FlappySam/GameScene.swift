//
//  GameScene.swift
//  FlappySam
//
//  Created by Przemysław Wawrzyniak on 07.03.2016.
//  Copyright (c) 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let playerCategory: UInt32 = 0x1
    let pipeCategory: UInt32 = 0x1 << 1
    let platformCategory: UInt32 = 0x1 << 2
    var player: Player?
    var platform: Platform?
    
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            preparePlayerNode()
            preparePlatform()
            preparePipes()
            physicsWorld.contactDelegate = self
            contentCreated = true
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        for node in children {
            node.removeAllActions()
        }
    }
    
    func preparePlayerNode() {
        player = Player(width: self.frame.width, factor: 0.2)
        player!.node.position = CGPointMake(self.frame.width * 0.35, CGRectGetMidY(self.frame))
        player!.node.zPosition = 1
        addChild(player!.node)
        player!.node.physicsBody!.categoryBitMask = playerCategory
        player!.node.physicsBody!.contactTestBitMask = pipeCategory | platformCategory
    }
    
    func preparePlatform() {
        platform = Platform(width: self.frame.width, factor: 0.1)
        platform!.node.anchorPoint = CGPointMake(0, 0)
        platform!.node.position = CGPointMake(0, 0)
        addChild(platform!.node)
        platform!.node.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveByX(-platform!.getTileWidth(), y: 0, duration: 0.5),
                SKAction.moveByX(platform!.getTileWidth(), y: 0, duration: 0)])))
        platform!.setCategory(platformCategory)
    }
    
    func preparePipes() {
        preparePipe(0.8 * self.frame.width)
        preparePipe(1.6 * self.frame.width)
    }
    
    func preparePipe(x: CGFloat) {
        let pipe = Pipe(parentFrame: self.frame.size, factor: CGPointMake(0.2, 0.3))
        pipe.node.anchorPoint = CGPointMake(0, 0)
        pipe.node.position = CGPointMake(x, platform!.getTileHeight())
        pipe.node.zPosition = -1
        pipe.node.name = "pipe"
        addChild(pipe.node)
        
        pipe.node.runAction(
            SKAction.repeatActionForever(
                SKAction.moveByX(-platform!.getTileWidth(), y: 0, duration: 0.5)))
        pipe.setCategory(pipeCategory)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player!.applyImpulse(self.frame.height * 0.75)
    }
   
    override func update(currentTime: CFTimeInterval) {
        enumerateChildNodesWithName("pipe", usingBlock: {
            if $0.0.position.x < -0.2 * self.frame.width {
                $0.0.removeFromParent()
                self.preparePipe(1.6 * self.frame.width + $0.0.position.x)
            }
        })
    }
}
