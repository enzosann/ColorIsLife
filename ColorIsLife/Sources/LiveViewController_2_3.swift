//
//  LiveViewController_2_2.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 17/03/2019.
//

import Foundation
import PlaygroundSupport
import SpriteKit

public class LiveViewController_2_3: LiveViewController{
    public override func viewDidLoad() {
        super.viewDidLoad()

        createScene()

    }
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    override public var shouldAutorotate: Bool {
        return true
    }

    public override func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        if case let .string(text) = message {
            switch text {
            case text:
                if text != ""{
                    greetingsScene()
                }
            default:
                break
            }
        }
    }
}


extension LiveViewController_2_3 {
    
   public func createScene() {
    
    if let view = self.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        if let scene = ConclusionScene(fileNamed: "SpriteScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(scene)
            
            
        }
        view.ignoresSiblingOrder = true

    }
    
    
    }
    
    public func greetingsScene() {

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GreetingsScene(fileNamed: "SpriteScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view.presentScene(scene)
                
                
            }
            view.ignoresSiblingOrder = true
            
        }
    
    }
}
