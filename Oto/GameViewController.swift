//
//  GameViewController.swift
//  Oto
//
//  Created by Enrik on 9/10/16.
//  Copyright (c) 2016 Enrik. All rights reserved.
//

import UIKit
import SpriteKit

var gameStage: Int = 0

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        let gameScene = GameScene(size: skView.frame.size)
        
        gameStage = 1
        
        skView.presentScene(gameScene)
        
    }

    
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
}
