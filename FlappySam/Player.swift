//
//  Player.swift
//  FlappySam
//
//  Created by Przemysław Wawrzyniak on 07.03.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import SpriteKit

class Player {
    let node = SKSpriteNode(imageNamed: "frame-1")
    let factor: CGFloat
    
    init(width: CGFloat, factor: CGFloat) {
        self.factor = width * factor / node.size.width
        
        node.xScale = self.factor
        node.yScale = self.factor
        addAnimation()
        preparePhysics()
    }
    
    func addAnimation() {
        let frame1 = SKTexture(imageNamed: "frame-1")
        let frame2 = SKTexture(imageNamed: "frame-2")
        let frame3 = SKTexture(imageNamed: "frame-3")
        let frame4 = SKTexture(imageNamed: "frame-4")
        node.runAction(
            SKAction.repeatActionForever(
                SKAction.animateWithTextures([frame1, frame2, frame3, frame4], timePerFrame: 0.1)))
    }
    
    func preparePhysics() {
        node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
        node.physicsBody!.allowsRotation = false
        node.physicsBody!.dynamic = true
    }
    
    func applyImpulse(velocityDy: CGFloat) {
        let velocity = node.physicsBody!.velocity.dy
        node.physicsBody!.applyImpulse(CGVectorMake(0, (-velocity + velocityDy) * node.physicsBody!.mass))
    }
}
