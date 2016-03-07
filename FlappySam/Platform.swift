//
//  Platform.swift
//  FlappySam
//
//  Created by Przemysław Wawrzyniak on 07.03.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import SpriteKit

class Platform {
    let node = SKSpriteNode()
    private let texture = SKTexture(imageNamed: "platform")
    private let factor: CGFloat
    
    init(width: CGFloat, factor: CGFloat) {
        self.factor = factor * width / texture.size().width
        self.fillFloorWithTales(width)
    }
    
    func fillFloorWithTales(width: CGFloat) {
        var index: CGFloat = 0
        var w = width
        while w > 0 {
            let node = createTileNode(index++ * texture.size().width)
            self.node.addChild(node)
            w -= node.frame.width
        }
        node.addChild(createTileNode(index * texture.size().width))
    }
    
    func getTileWidth() -> CGFloat {
        return factor * texture.size().width
    }
    
    func createTileNode(x: CGFloat) -> SKSpriteNode {
        let tileNode = SKSpriteNode(texture: texture)
        tileNode.xScale = factor
        tileNode.yScale = factor
        tileNode.anchorPoint = CGPointMake(0, 0)
        tileNode.position = CGPointMake(x * factor, 0)
        preparePhysics(tileNode)
        return tileNode
    }
    
    func preparePhysics(node: SKSpriteNode) {
        node.physicsBody
            = SKPhysicsBody(rectangleOfSize: node.size,
                            center: CGPointMake(CGRectGetMidX(node.frame), CGRectGetMidY(node.frame)))
        node.physicsBody!.dynamic = false
    }
}
