//
//  GameScene.swift
//  onemodified
//
//  Created by Phil Rosenberger on 2/20/17.
//  Copyright © 2017 onehelloworld. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Ghost : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3

}

class GameScene: SKScene {
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    let wallPair = SKNode()

    
    override func sceneDidLoad() {
        
        Ground = SKSpriteNode(imageNamed: "Ground")
        Ground.setScale(0.81)
        Ground.position = CGPoint(x: 0 , y: 0 + Ground.frame.height / 2)
        
        Ground.physicsBody = SKPhysicsBody(rectangleOf: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        Ground.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.isDynamic = false
        
        Ground.zPosition = 3
        
        self.addChild(Ground)
        
        Ghost = SKSpriteNode(imageNamed: "Ghost")
        Ghost.size = CGSize(width: 60, height: 70)
        Ghost.position = CGPoint(x: self.frame.width / 2 - Ghost.frame.width, y: self.frame.height / 2)
        
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = PhysicsCategory.Ghost
        Ghost.physicsBody?.collisionBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Ghost.physicsBody?.contactTestBitMask = PhysicsCategory.Ground | PhysicsCategory.Wall
        Ghost.physicsBody?.affectedByGravity = true
        Ghost.physicsBody?.isDynamic = true
        
        Ghost.zPosition = 2
        
        self.addChild(Ghost)
        
        let spawn = SKAction.run {
            
            () in
            self.createWalls()
        }
        
        let delay = SKAction.wait(forDuration: 2.0)
        let spawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        
        let distance = CGFloat(self.frame.width + 20)
        
    }
    
    func createWalls(){
        
        let topWall = SKSpriteNode(imageNamed:"Wall")
        let btmWall = SKSpriteNode(imageNamed:"Wall")
        
        topWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 350)
        btmWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        topWall.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        topWall.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.isDynamic = false
        
        topWall.zRotation = CGFloat(M_PI)
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = PhysicsCategory.Wall
        btmWall.physicsBody?.collisionBitMask = PhysicsCategory.Ghost
        btmWall.physicsBody?.contactTestBitMask = PhysicsCategory.Ghost
        btmWall.physicsBody?.affectedByGravity = false
        btmWall.physicsBody?.isDynamic = false
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        
        self.addChild(wallPair)


    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        Ghost.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
