//
//  LiveViewController_2_2.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 17/03/2019.
//

import Foundation
import PlaygroundSupport
import SpriteKit

public class LiveViewController_2_2: LiveViewController{
    var difficultCount: Int = 0
    public override func viewDidLoad() {
        super.viewDidLoad()


    }


    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    override public var shouldAutorotate: Bool {
        return true
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    func handleApplicationWillResignActive (_ note: Notification) {
        let skView = self.view as! SKView
        skView.isPaused = true
    }
    
    func handleApplicationDidBecomeActive (_ note: Notification) {
        let skView = self.view as! SKView
        skView.isPaused = false
    }

    public override func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        if case let .integer(text) = message {
            switch text {
            case text:
                difficultCount = text
                createScene()
            default:
                break
            }
        }
    }
}


extension LiveViewController_2_2 {
    
   public func createScene() {
    // Configure the view.
    let skView = self.view as! SKView
    skView.showsFPS = false
    skView.showsNodeCount = false
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = true
    
    // Create and configure the scene.
    let scene = ThirdGameScene(size: skView.frame.size)
    scene.contactCount = difficultCount
    scene.backgroundColor = SKColor.init(red: 9/255, green: 16/255, blue: 49/255, alpha: 1)
    scene.scaleMode = .aspectFit
    skView.presentScene(scene)
    skView.showsPhysics = false
    }

}
