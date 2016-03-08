//
//  Pipe.swift
//  FlappySam
//
//  Created by Przemysław Wawrzyniak on 08.03.2016.
//  Copyright © 2016 Przemyslaw Wawrzyniak. All rights reserved.
//

import SpriteKit

class Pipe {
    let node = SKSpriteNode()
    private let texture = SKTexture(imageNamed: "pipe")
    private let factor: CGPoint
    
    init(parentFrame: CGSize, factor: CGPoint) {
        self.factor = CGPointMake(factor.x * parentFrame.width / texture.size().width,
                                  factor.y * parentFrame.height / texture.size().height)
    
        let randomNum = CGFloat(rand()) % (parentFrame.height * (0.6 - factor.y))
        let hole = CGRectMake(0, parentFrame.height * 0.2 + randomNum, 0, parentFrame.height * factor.y)
        
        createTopPipe(parentFrame, endPoint: parentFrame.height - hole.origin.y - hole.height);
        createBottomPipe(parentFrame, endPoint: hole.origin.y)
    }
    
    func createTopPipe(parentFrame: CGSize, endPoint: CGFloat) {
        let node = SKSpriteNode(texture: texture)

        node.xScale = factor.x
        node.size.height = endPoint
        node.centerRect = CGRectMake(0.4, 0.4, 0.2, 0.2)
        node.anchorPoint = CGPointMake(0, 1)
        preparePhysics(node)
        
        node.position = CGPointMake(0, parentFrame.height)
        self.node.addChild(node)
    }
    
    func createBottomPipe(parentFrame: CGSize,  endPoint: CGFloat) {
        let node = SKSpriteNode(texture: texture)

        node.xScale = factor.x
        node.size.height = endPoint
        node.centerRect = CGRectMake(0.4, 0.4, 0.2, 0.2)
        node.anchorPoint = CGPointMake(0, 0)
        preparePhysics(node)
        self.node.addChild(node)
    }

    func setCategory(category: UInt32) {
        for node in self.node.children {
            node.physicsBody!.categoryBitMask = category
        }
    }
    
    func preparePhysics(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size,
                                         center: CGPointMake(CGRectGetMidX(node.frame),
                                                             CGRectGetMidY(node.frame)))
        node.physicsBody!.dynamic = false
    }
}
