//
//  MapViewController.swift
//  nervous
//
//  Created by Sam Sulaimanov on 20/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//
import UIKit
import SpriteKit

class MapViewController: UIViewController {
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        let scene = GameScene(fileNamed:"MapScene")
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 4
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}