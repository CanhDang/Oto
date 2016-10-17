//
//  GiftAmorController.swift
//  Oto
//
//  Created by Enrik on 10/2/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class GiftAmorController: BaseController {
    
    let SPEED: Double = 130
    
    override func setup(_ parent: SKNode) {
        addRunAction(parent)
        setupPhysics()
        setupContact(parent)
    }
    
    func setupContact(_ parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let playerCarView = otherView as? PlayerCarView {
                if let eatGiftAmor = playerCarView.eatGiftAmor {
                    eatGiftAmor()
                }
                
                parent.run(SKAction.playSoundFileNamed("Powerup.wav", waitForCompletion: false))
                self.view.removeFromParent()
            }
        }
    }
    
    func addRunAction(_ parent: SKNode) {
        
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height)
        
        let timeToBottom = distanceToBottom / SPEED
        
        self.view.run(
            SKAction.sequence(
                [
                    SKAction.moveTo(y: -self.view.frame.height, duration: timeToBottom),
                    SKAction.removeFromParent()
                ]
            )
            
        )
        
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_GIFT_AMOR
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER_CAR
    }
    
}
