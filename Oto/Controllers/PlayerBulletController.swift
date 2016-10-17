//
//  PlayerBulletController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PlayerBulletController: BaseController {
    
    let SPEED: Double = 60
    
    override func setup(_ parent: SKNode) {
        setupPhysics()
        addActionFly(parent)
        setupContact()
    }
    
    func setupContact() {
        self.view.handleContact = {
            otherView in
            if let enemyCarView = otherView as? EnemyCarView {
                
            }
            
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
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_BULLET
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY_CAR
    }

    
}
