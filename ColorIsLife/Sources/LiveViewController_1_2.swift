//
//  LiveViewController_1_2.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 17/03/2019.
//

import Foundation
import PlaygroundSupport
import SpriteKit

public class LiveViewController_1_2: LiveViewController{
    
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

extension LiveViewController_1_2{
    public func createScene(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "SpriteScene") {
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                scene.isUserInteractionEnabled = false
                scene.hintsTextString = "Welcome"
                _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { timer in
                    scene.GluonDC()
                    scene.GluonTL()
                    scene.GluonTR()
                })

                scene.hintsNode?.removeFromParent()
                scene.hintsShapeNode?.removeFromParent()
            }

        }
}

}
