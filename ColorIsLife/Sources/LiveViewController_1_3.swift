//
//  LiveViewController_1_3.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 17/03/2019.
//

import Foundation
import PlaygroundSupport
import SpriteKit

public class LiveViewController_1_3: LiveViewController{
    var rightArrowNode: SKNode?

    
    
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

extension LiveViewController_1_3{
    
    public func createScene(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "SpriteScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
    func shake(duration: Double, amplitudeX: CGFloat = 10, amplitudeY: CGFloat = 0) -> SKAction {
        let numberOfShakes = duration / 0.015 / 2.0
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let dx = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let dy = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            let forward = SKAction.moveBy(x: dx, y:dy, duration: 0.4)
            let reverse = forward.reversed()
            actionsArray.append(forward)
            actionsArray.append(reverse)
        }
        return SKAction.sequence(actionsArray)
    }
    
}

