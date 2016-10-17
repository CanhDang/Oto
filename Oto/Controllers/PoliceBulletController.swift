//
//  PoliceBulletController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PoliceBulletController: BaseController {
    
    let SPEED: Double = 40
    
    override func setup(_ parent: SKNode) {
        setupPhysics()
        addActionFly(parent)
        setupContact(parent)
    }
    
    func setupContact(_ parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let getHitPoliceBullet = playerCarView.getHitPoliceBullet {
                    getHitPoliceBullet()
                }
            }
            parent.run(SKAction.playSoundFileNamed("PlayerHitBullet.wav", waitForCompletion: false))
            self.view.removeFromParent()
        }
    }
    
    func addActionFly(_ parent: SKNode) {
        let distanceToTop = Double(parent.frame.height + self.view.frame.height - self.view.position.y)
        
        let timeToReachTop = distanceToTop / SPEED
        
        self.view.run(
            SKAction.sequence([
                SKAction.moveTo(y: parent.frame.height + self.view.frame.height, duration: timeToReachTop),
                SKAction.removeFromParent()
            ])
        )
    }
    
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(circleOfRadius: self.view.frame.width / 2 - 5 )
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_POLICE_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR
    }
}
