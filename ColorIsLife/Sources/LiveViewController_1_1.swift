//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import Foundation
import PlaygroundSupport
import SpriteKit




public class LiveViewController_1_1: LiveViewController {
    
    
    
    public override func viewDidLoad() {
    }

    public override func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        if case let .boolean(text) = message {
            switch text {
            case true:
                createScene()
            default:
                break
            }
        }
    }

}

extension LiveViewController_1_1{
    public func createScene(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "SpriteScene") {
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                    scene.isUserInteractionEnabled = false
                    scene.hintsNode?.removeFromParent()
                    scene.hintsShapeNode?.removeFromParent()
            }
            view.ignoresSiblingOrder = true
        }
    }
    

}
