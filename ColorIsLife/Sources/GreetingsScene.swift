//
//  Greetings.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 24/03/2019.
//

import Foundation
import UIKit
import SpriteKit

class GreetingsScene: SKScene {
    
    // Private GameScene Properties
    
    var contentCreated = false
    
    // Object Lifecycle Management
    
    // Scene Setup and Content Creation
    
    override func didMove(to view: SKView) {
        
        if (!self.contentCreated) {
            self.createContent()
            self.contentCreated = true
        }
    }
    
    func createContent() {
        let greetingsLabel = SKLabelNode(fontNamed: "SFPro")
        let greetingsLabel2 = SKLabelNode(fontNamed: "SFPro")
        greetingsLabel.fontSize = 50
        greetingsLabel.fontColor = SKColor.white
        greetingsLabel.text = "If it can be done I can do it."
        greetingsLabel2.text = "(@Enzosan)"
        greetingsLabel2.fontSize = 40
        greetingsLabel2.fontColor = SKColor.white
        greetingsLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 35);
        greetingsLabel2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 35);

        self.addChild(greetingsLabel)
        self.addChild(greetingsLabel2)

        
        // black space color
        self.backgroundColor = SKColor.black
        
    }


}
