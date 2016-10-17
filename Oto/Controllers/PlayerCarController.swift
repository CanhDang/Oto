//
//  PlayerCarController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class PlayerCarController: BaseController{
    
    let MAX_HEALTH: CGFloat = 70
    
    var health: CGFloat = 50
    var isShielded: Bool = false
    var isSlow: Bool = false
    
    override func setup(_ parent: SKNode) {
       setupPhysics()
       setupRespond(parent)
       
        
    }
    
    func setupRespond(_ parent: SKNode) {
        if let playerCarView = self.view as? PlayerCarView {
            playerCarView.increaseHealth = {
                
                self.health += 10
                if self.health > self.MAX_HEALTH {
                    self.health = self.MAX_HEALTH
                }
                
            }
            playerCarView.crashEnemy = {
                if self.isShielded == false {
                    if self.health > 0 {
                        self.health -= 20
                    }
                }
                
            }
            playerCarView.getHitPoliceBullet = {
                if self.isShielded == false {
                    if self.health > 0{
                         self.health -= 10
                    }
                }
            }
            playerCarView.eatGiftBullet = {
                self.addShotAction(parent)
            }
            playerCarView.eatGiftAmor = {
                self.takeShield()
                
            }
            playerCarView.eatPothHole = {
                self.slowMove()
            }
        }
    }
    
    func setupPhysics() {
        self.view.physicsBody = SKPhysicsBody(rectangleOf: self.view.size)
        self.view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_CAR
        self.view.physicsBody?.collisionBitMask = 0
        self.view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY_CAR | PHYSICS_MASK_POLICE_CAR
    }
    
    func increaseHealthForPlayer() {
        self.health += 10
    }
    
    
    func addShotAction(_ parent: SKNode) {
        self.view.run(
            SKAction.repeat(
                SKAction.sequence([
                SKAction.run { self.addBullet(parent) },
                SKAction.wait(forDuration: 1)
                ])
            ,count: 5)
        )
        
    }

    func addBullet(_ parent: SKNode) {
        let playerBulletView = View(imageNamed: "playerBullet.png")
        playerBulletView.position = self.view.position
        
        let playerBulletController = PlayerBulletController(view: playerBulletView)
        playerBulletController.setup(parent)
        parent.run(SKAction.playSoundFileNamed("PlayerBullet.wav", waitForCompletion: false))
        playerBulletView.zPosition = ZPOSITION_BULLET
        parent.addChild(playerBulletView)
    }
    
    
    func takeShield() {
        var textures : [SKTexture] = []
        for i in 1...5 {
            let imageName = "Car\(i).png"
            let texture = SKTexture(imageNamed: imageName)
            textures.append(texture)
        }
        
        let animate = SKAction.animate(with: textures, timePerFrame: 0.02)
        
        self.view.run(
            SKAction.sequence([
                SKAction.run({ 
                    self.isShielded = true
                    self.view.run(SKAction.repeat(animate, count: 50))
                }),
                SKAction.wait(forDuration: 5),
                SKAction.run({ 
                    self.isShielded = false
                })
            ])
        )
    }
    
    func slowMove() {
        
        self.view.run(
            SKAction.sequence([
                SKAction.run({ 
                    self.isSlow = true
                }),
                SKAction.repeat(SKAction.sequence([
                   SKAction.rotate(byAngle: 0.1, duration: 0.3),
                   SKAction.rotate(byAngle: -0.1, duration: 0.3)
                        ])
                        , count: 8)
                ,
                SKAction.wait(forDuration: 4),
                SKAction.run({ 
                    self.isSlow = false
                })
                
                
            ])
            
        )
        
        self.view.zRotation = 0
    }

}












