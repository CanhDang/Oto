//
//  FireController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class FireController {
    
    var view: SKEmitterNode!
    let SPEED: Double = 200
    
    init(parent: SKNode, position: CGPoint){
        if let explosionPath = Bundle.main.path(forResource: "Explosion", ofType: "sks") {
            view = NSKeyedUnarchiver.unarchiveObject(withFile: explosionPath) as? SKEmitterNode
            
            view.position = position
            parent.addChild(view)
        }
    }
    
    func setup() {
        let distanceToBottom = Double(self.view.position.y + self.view.frame.height )
        let timeToBottom = distanceToBottom / SPEED
        self.view.run(
            SKAction.sequence([
                SKAction.moveTo(y: -self.view.frame.height, duration: timeToBottom),
                SKAction.removeFromParent()
            ])
        )
    }
}
