//
//  ThirdGameScene.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 23/03/2019.
//

import Foundation
import SpriteKit
import GameplayKit

//set the bit mask categories
let playerCategory: UInt32 = 0x1 << 1
let RainFallCategory: UInt32 = 0x1 << 2
let floorCategory: UInt32 = 0x1 << 3
var quarkImage = SKTexture(imageNamed: "quarkBlue")

class ThirdGameScene: SKScene, SKPhysicsContactDelegate {
    var contactCount: Int = 0
    var scoreNode: SKNode?
    var playerNode: SKNode?
    var rainNode: SKNode?
    var gameEnding: Bool = false

//    create an instance of the person
    let player = quarkPlayer(image: SKSpriteNode(texture: quarkImage))

    let floor = Floor()
    
//    add the instance to the ThirdGameScene
    override func didMove(to view: SKView) {
        self.addChild(player)
        self.addChild(floor)
        player.run(RotationLoop)
        player.run(DistortionLoop)
    }
    
    override func sceneDidLoad() {
        scoreLabel()
//        set the game scene ad the physixs protocol delegate
        self.physicsWorld.contactDelegate = self
    }
    
//    handle what happens when user touch the quark on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.move(touchLocation: (touches.first?.location(in: self))!)

    }
    
//    handle what happens when user drags the quark across the screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.move(touchLocation: (touches.first?.location(in: self))!)

    }
    
    override func update(_ currentTime: TimeInterval) {
        spawnRain()
    }
    // MARK: - Creation function for hints label
    func scoreLabel(){

        let scoreLabel = SKLabelNode(text: "\(contactCount)")
        scoreLabel.position = CGPoint(x:  self.size.width/2, y: self.size.height - 50)
        scoreLabel.fontSize = CGFloat(24)
        scoreLabel.fontName = "SFProDisplay"
        scoreLabel.xScale = 1
        scoreLabel.alpha = 1
        scoreLabel.zPosition = 1
        scoreNode = scoreLabel
        scoreLabel.fontColor = SKColor.white
        scoreLabel.name = "scoreLabel"
        let shapeLabel = SKSpriteNode(imageNamed: "scoreShape")
        shapeLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 42)
        shapeLabel.xScale = 0.15
        shapeLabel.yScale = 0.15
        self.addChild(scoreLabel)
        self.addChild(shapeLabel)
    }
    func spawnRain(){
        let rainFall = RainFall(image: SKSpriteNode(imageNamed: "red-yellow"))
        rainNode = rainFall
        self.addChild(rainFall)
        rainFall.run(RotationLoop)
        rainFall.run(DistortionLoop)
    }
    
//    handle contact events
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == RainFallCategory) && (contact.bodyB.categoryBitMask == floorCategory) {
            contact.bodyA.node?.removeFromParent()
        } else if (contact.bodyA.categoryBitMask == floorCategory) && (contact.bodyB.categoryBitMask == RainFallCategory) {
            contact.bodyB.node?.removeFromParent()
        } else if (contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == RainFallCategory) {
            contact.bodyB.node?.removeFromParent()
            contactCount -= 1
            scoreNode?.removeFromParent()
            scoreLabel()
            if contactCount == 0 {
                contactCount = 150
            endGame()
            }
        }
    }
    
    func endGame() {
        // 1
        if !gameEnding {
            
            gameEnding = true

            
            // 3
            let gameOverScene: ThirdGameOverScene = ThirdGameOverScene(size: size)
            
            view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
        }
    }
}

