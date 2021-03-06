//
//  EnemyCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class EnemyCarController: BaseController {
    
    override func setup(_ parent: SKNode) {
        setupPhysics()
        setupContact(parent)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllEnemy(_:)), name: NSNotification.Name(rawValue: "Eat Bomb"), object: nil)
    }
    
    @objc func removeAllEnemy(_ notification: Notification) {
        if let info = (notification as NSNotification).userInfo as? Dictionary<String,SKNode> {
            if let parent = info["parent"] {
                for child in parent.children {
                    if child.name == "enemy" {
                        self.addExplosionEffect(parent, position: child.position)
                        child.removeFromParent()
                        
                    }
                    
                }
            }
        }
    }
    
    func setupContact(_ parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let crashEnemy = playerCarView.crashEnemy {
                    crashEnemy()
                }
            } else if let policeCarView = otherView as? PoliceCarView {
            
               let dic: NSDictionary = ["AddHealth":10]
               NotificationCenter.default.post(name: Notification.Name(rawValue: "Increase Health"), object: nil, userInfo: dic as! [AnyHashable: Any])
                
            }
            parent.run(SKAction.playSoundFileNamed("CrashCar.mp3", waitForCompletion: false))
            self.addExplosionEffect(parent, position: self.view.position)
            self.view.removeFromParent()
        }
    }
    
    func addExplosionEffect(_ parent: SKNode, position: CGPoint) {
        let explosion = FireController(parent: parent, position: position)
        explosion.setup()
    }
    
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY_CAR
        self.view.physicsBody?.collisionBitMask = PHYSICS_MASK_ENEMY_CAR
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR | PHYSICS_MASK_POLICE_CAR
    }
    
    func addRunAction(_ speed: Double, parent: SKNode) {
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height)
        
        let timeToReachBottom = distanceToBottom / speed
        
        self.view.run(
            SKAction.sequence(
                [
                    SKAction.moveTo(y: -self.view.frame.height, duration: timeToReachBottom),
                    SKAction.removeFromParent()
                ]
            )
        )
        
    }
}
