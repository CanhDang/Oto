//
//  BaseController.swift
//  Oto
//
//  Created by Enrik on 10/1/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import SpriteKit

class BaseController {
    internal let view: View
    
    init(view: View) {
        self.view = view
    }
    
    func setup(_ parent: SKNode) {
        
    }
    
    
    func moveTo(_ position: CGPoint) {
        self.view.position = position
    }
    
    func moveBy(_ vector: CGPoint) {
        self.view.position = CGPoint(x: self.view.position.x + vector.x, y: self.view.position.y + vector.y)
    }
    
    func moveByDx(_ dx : CGFloat) {
        self.view.position = CGPoint(x: self.view.position.x + dx, y: self.view.position.y)
    }
}
