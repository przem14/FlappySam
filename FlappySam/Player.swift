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
    
    init() {
        addAnimation()
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
}
