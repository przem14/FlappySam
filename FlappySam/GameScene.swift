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
    
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            preparePlayerNode()
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
