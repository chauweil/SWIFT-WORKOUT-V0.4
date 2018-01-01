//
//  GameScene.swift
//  training beginner
//
//  Created by Jeff on 01/01/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
let coreMotionManager = CMMotionManager()
    
    let backgroundNode = SKSpriteNode(imageNamed: "back")
    let playerNode = SKSpriteNode(imageNamed: "yue2")

    var impulseCount = 23
    let CollisionCategoryPlayer  : UInt32 = 0x1 << 1
    let CollisionCategoryPowerUpOrbs : UInt32 = 0x1 << 2
    let foregroundNode = SKSpriteNode()
    
    override init(size: CGSize) {
        super.init(size: size)
        physicsWorld.gravity = CGVector(dx: 0.0, dy:  -0.5);
        physicsWorld.contactDelegate = self

        backgroundNode.size.width = frame.size.width
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        backgroundNode.position = CGPoint(x: size.width / 2.0, y: 0.0)
        addChild(backgroundNode)
        addChild(foregroundNode)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width / 2)
        playerNode.physicsBody?.isDynamic = false
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.linearDamping = 1.0
        
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryPlayer
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryPowerUpOrbs
        playerNode.physicsBody?.collisionBitMask = 0

        
        playerNode.position = CGPoint(x: size.width / 2.0, y: 180.0)
        foregroundNode.addChild(playerNode)
        
        var orbNodePosition = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 50)
        for _ in 0...19 {
            let orbNode = SKSpriteNode(imageNamed: "kfc")
            orbNodePosition.y += 80
            orbNode.position = orbNodePosition
            orbNode.physicsBody = SKPhysicsBody(circleOfRadius: orbNode.size.width / 2)
            orbNode.physicsBody?.isDynamic = false
            orbNode.physicsBody?.categoryBitMask = CollisionCategoryPowerUpOrbs
            orbNode.physicsBody?.collisionBitMask = 0
            orbNode.name = "POWER_UP_ORB"
            foregroundNode.addChild(orbNode)
        }
        
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if playerNode.position.y >= 180.0 {
            backgroundNode.position =
                CGPoint(x: backgroundNode.position.x,
                        y: -((playerNode.position.y - 180.0)/8))
            foregroundNode.position =
                CGPoint(x: foregroundNode.position.x,
                        y: -(playerNode.position.y - 180.0))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if !playerNode.physicsBody!.isDynamic {
            playerNode.physicsBody?.isDynamic = true
            coreMotionManager.accelerometerUpdateInterval = 0.3
            coreMotionManager.startAccelerometerUpdates()
        }
        if impulseCount > 0 {
            playerNode.physicsBody!.applyImpulse(CGVector(dx: 0.0, dy: 40.0))
            impulseCount -= 1
        }
        
    }
    
    override func didSimulatePhysics() {
        
        
        if let accelerometerData = coreMotionManager.accelerometerData {
            playerNode.physicsBody!.velocity =
                CGVector(dx: CGFloat(accelerometerData.acceleration.x * 380.0),
                         dy: playerNode.physicsBody!.velocity.dy)
        }
        
        
        if playerNode.position.x < -(playerNode.size.width / 2) {
            playerNode.position = CGPoint(x: size.width - playerNode.size.width / 2,y: playerNode.position.y);}
        else if playerNode.position.x > self.size.width {playerNode.position = CGPoint(x: playerNode.size.width / 2,y: playerNode.position.y);
            }
        
        
    }


    deinit {
        coreMotionManager.stopAccelerometerUpdates()
            }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeB = contact.bodyB.node
        
        if nodeB?.name == "POWER_UP_ORB" {
            impulseCount += 1
            nodeB?.removeFromParent()
            
        }
        
        
        
    }
}



