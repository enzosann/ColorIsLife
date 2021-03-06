//
//  SecondGameScene.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 22/03/2019.
//

import Foundation
import SpriteKit
import CoreMotion

class SecondGameScene: SKScene, SKPhysicsContactDelegate {
    var imageQuark = SKTexture(imageNamed: "redQuark")

    // Private GameScene Properties
    
    let motionManager = CMMotionManager()
    var contentCreated = false
    
    // 1
    var invaderMovementDirection: InvaderMovementDirection = .right
    // 2
    var timeOfLastMove: CFTimeInterval = 0.0
    // 3
    var timePerMove: CFTimeInterval = 1.0
    
    var tapQueue = [Int]()
    var contactQueue = [SKPhysicsContact]()
    
    var score: Int = 0
    var quarkHealth: Float = 1.0
    
    let kMinInvaderBottomHeight: Float = 32.0
    var gameEnding: Bool = false
    
    enum InvaderType {
        case a
        case b
        case c
        
        static var size: CGSize {
            return CGSize(width: 24, height: 16)
        }
        
        static var name: String {
            return "invader"
        }
    }
    
    enum InvaderMovementDirection {
        case right
        case left
        case downThenRight
        case downThenLeft
        case none
    }
    
    enum BulletType {
        case quarkFired
        case invaderFired
    }
    
    let kInvaderGridSpacing = CGSize(width: 12, height: 12)
    let kInvaderRowCount = 6
    let kInvaderColCount = 6
    
    let kQuarkSize = CGSize(width: 25, height: 25)
    let kQuarkName = "quark"
    
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "healthHud"
    
    let kQuarkFiredBulletName = "quarkFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    let kBulletSize = CGSize(width:4, height: 8)
    
    let kInvaderCategory: UInt32 = 0x1 << 0
    let kQuarkFiredBulletCategory: UInt32 = 0x1 << 1
    let kQuarkCategory: UInt32 = 0x1 << 2
    let kSceneEdgeCategory: UInt32 = 0x1 << 3
    let kInvaderFiredBulletCategory: UInt32 = 0x1 << 4
    
    // Object Lifecycle Management
    
    // Scene Setup and Content Creation
    
    override func didMove(to view: SKView) {
        
        if (!self.contentCreated) {
            self.createContent()
            self.contentCreated = true
            motionManager.startAccelerometerUpdates()
            physicsWorld.contactDelegate = self
        }
    }
    
    func createContent() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody!.categoryBitMask = kSceneEdgeCategory
        
        setupInvaders()
        setupQuark()
        setupHud()
        
        // black space color
        self.backgroundColor = SKColor.black
    }

    
    func makeInvader(ofType invaderType: InvaderType) -> SKNode {
        
        // 2
        let gluon = SKSpriteNode(imageNamed: "red-yellow")
        gluon.name = InvaderType.name
        gluon.xScale = 0.03
        gluon.yScale = 0.03
        // 3
        gluon.run(SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "red-yellow"), SKTexture(imageNamed: "red-cyan"), SKTexture(imageNamed: "green-magenta")], timePerFrame: timePerMove)))
        
        // invaders' bitmasks setup
        gluon.physicsBody = SKPhysicsBody(rectangleOf: gluon.frame.size)
        gluon.physicsBody!.isDynamic = false
        gluon.physicsBody!.categoryBitMask = kInvaderCategory
        gluon.physicsBody!.contactTestBitMask = 0x0
        gluon.physicsBody!.collisionBitMask = 0x0
        gluon.run(RotationLoop)
        gluon.run(DistortionLoop)
        return gluon
    }
    
    func setupInvaders() {
        // 1
        let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 2)
        
        for row in 0..<kInvaderRowCount {
            // 2
            var invaderType: InvaderType
            
            if row % 3 == 0 {
                invaderType = .a
            } else if row % 3 == 1 {
                invaderType = .b
            } else {
                invaderType = .c
            }
            
            // 3
            let invaderPositionY = CGFloat(row) * (InvaderType.size.height * 2) + baseOrigin.y
            
            var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
            
            // 4
            for _ in 1..<kInvaderRowCount {
                // 5
                let invader = makeInvader(ofType: invaderType)
                invader.position = invaderPosition
                
                addChild(invader)
                
                invaderPosition = CGPoint(
                    x: invaderPosition.x + InvaderType.size.width + kInvaderGridSpacing.width,
                    y: invaderPositionY
                )
            }
        }
    }
    
    func setupQuark() {
        // 1
        let quark = makeQuark()
        
        // 2
        quark.position = CGPoint(x: size.width / 2.0, y: 20)
        addChild(quark)
    }
    
    func makeQuark() -> SKNode {
        let quark = SKSpriteNode(texture: imageQuark)
        quark.name = kQuarkName
        quark.xScale = 0.10
        quark.yScale = 0.10
        // 1
        quark.physicsBody = SKPhysicsBody(rectangleOf: quark.frame.size)
        
        // 2
        quark.physicsBody!.isDynamic = true
        
        // 3
        quark.physicsBody!.affectedByGravity = true
        
        // 4
        quark.physicsBody!.mass = 0.02
        
        // 1
        quark.physicsBody!.categoryBitMask = kQuarkCategory
        // 2
        quark.physicsBody!.contactTestBitMask = 0x0
        // 3
        quark.physicsBody!.collisionBitMask = kSceneEdgeCategory
        quark.run(RotationLoop)
        quark.run(DistortionLoop)
        return quark
    }
    
    func setupHud() {
        // 1
        let scoreLabel = SKLabelNode(fontNamed: "SFPro")
        scoreLabel.name = kScoreHudName
        scoreLabel.fontSize = 25
        
        // 2
        scoreLabel.fontColor = SKColor.white
        scoreLabel.text = String(format: "Score: %04u", 0)
        
        // 3
        scoreLabel.position = CGPoint(
            x: frame.size.width / 2,
            y: size.height - (40 + scoreLabel.frame.size.height/2)
        )
        addChild(scoreLabel)
        
        // 4
        let healthLabel = SKLabelNode(fontNamed: "SFPro")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        
        // 5
        healthLabel.fontColor = SKColor.red
        healthLabel.text = String(format: "Health: %.1f%%", quarkHealth * 100.0)
        
        // 6
        healthLabel.position = CGPoint(
            x: frame.size.width / 2,
            y: size.height - (80 + healthLabel.frame.size.height/2)
        )
        addChild(healthLabel)
    }
    
    func adjustScore(by points: Int) {
        score += points
        
        if let score = childNode(withName: kScoreHudName) as? SKLabelNode {
            score.text = String(format: "Score: %04u", self.score)
        }
    }
    
    func adjustQuarkHealth(by healthAdjustment: Float) {
        // 1
        quarkHealth = max(quarkHealth + healthAdjustment, 0)
        
        if let health = childNode(withName: kHealthHudName) as? SKLabelNode {
            health.text = String(format: "Health: %.1f%%", self.quarkHealth * 100)
        }
    }
    
    func makeBullet(ofType bulletType: BulletType) -> SKNode {
        var bullet: SKNode
        
        switch bulletType {
        case .quarkFired:
            bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
            bullet.name = kQuarkFiredBulletName
            
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
            bullet.physicsBody!.isDynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kQuarkFiredBulletCategory
            bullet.physicsBody!.contactTestBitMask = kInvaderCategory
            bullet.physicsBody!.collisionBitMask = 0x0
        case .invaderFired:
            bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
            
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
            bullet.physicsBody!.isDynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kInvaderFiredBulletCategory
            bullet.physicsBody!.contactTestBitMask = kQuarkCategory
            bullet.physicsBody!.collisionBitMask = 0x0
            break
        }
        
        return bullet
    }
    
    // Scene Update
    
    func moveInvaders(forUpdate currentTime: CFTimeInterval) {
        // 1
        if (currentTime - timeOfLastMove < timePerMove) {
            return
        }
        
        determineInvaderMovementDirection()
        
        // 2
        enumerateChildNodes(withName: InvaderType.name) { node, stop in
            switch self.invaderMovementDirection {
            case .right:
                node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
            case .left:
                node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
            case .downThenLeft, .downThenRight:
                node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
            case .none:
                break
            }
            
            // 3
            self.timeOfLastMove = currentTime
        }
    }
    
    func adjustInvaderMovement(to timePerMove: CFTimeInterval) {
        // 1
        if self.timePerMove <= 0 {
            return
        }
        
        // 2
        let ratio: CGFloat = CGFloat(self.timePerMove / timePerMove)
        self.timePerMove = timePerMove
        
        // 3
        enumerateChildNodes(withName: InvaderType.name) { node, stop in
            node.speed = node.speed * ratio
        }
    }
    
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        // 1
        if let quark = childNode(withName: kQuarkName) as? SKSpriteNode {
            // 2
            if let data = motionManager.accelerometerData {
                // 3
                if fabs(data.acceleration.x) > 0.2 {
                    // 4 How do you move the quark?
                    quark.physicsBody!.applyForce(CGVector(dx: 40 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        }
    }
    
    func fireInvaderBullets(forUpdate currentTime: CFTimeInterval) {
        let existingBullet = childNode(withName: kInvaderFiredBulletName)
        
        // 1
        if existingBullet == nil {
            var allInvaders = [SKNode]()
            
            // 2
            enumerateChildNodes(withName: InvaderType.name) { node, stop in
                allInvaders.append(node)
            }
            
            if allInvaders.count > 0 {
                // 3
                let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
                
                let invader = allInvaders[allInvadersIndex]
                
                // 4
                let bullet = makeBullet(ofType: .invaderFired)
                bullet.position = CGPoint(
                    x: invader.position.x,
                    y: invader.position.y - invader.frame.size.height / 2 + bullet.frame.size.height / 2
                )
                
                // 5
                let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height / 2))
                
                // 6
                fireBullet(
                    bullet: bullet,
                    toDestination: bulletDestination,
                    withDuration: 2.0,
                    andSoundFileName: ""
                )
            }
        }
    }
    
    func processContacts(forUpdate currentTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            
            if let index = contactQueue.index(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isGameOver() {
            endGame()
        }
        
        processUserMotion(forUpdate: currentTime)
        moveInvaders(forUpdate: currentTime)
        processUserTaps(forUpdate: currentTime)
        fireInvaderBullets(forUpdate: currentTime)
        processContacts(forUpdate: currentTime)
    }
    
    // Scene Update Helpers
    
    func processUserTaps(forUpdate currentTime: CFTimeInterval) {
        // 1
        for tapCount in tapQueue {
            if tapCount == 1 {
                // 2
                fireQuarkBullets()
            }
            // 3
            tapQueue.remove(at: 0)
        }
    }
    
    // Invader Movement Helpers
    
    func determineInvaderMovementDirection() {
        // 1
        var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
        
        // 2
        enumerateChildNodes(withName: InvaderType.name) { node, stop in
            
            switch self.invaderMovementDirection {
            case .right:
                //3
                if (node.frame.maxX >= node.scene!.size.width - 1.0) {
                    proposedMovementDirection = .downThenLeft
                    
                    // Add the following line
                    self.adjustInvaderMovement(to: self.timePerMove * 0.8)
                    
                    stop.pointee = true
                }
            case .left:
                //4
                if (node.frame.minX <= 1.0) {
                    proposedMovementDirection = .downThenRight
                    
                    // Add the following line
                    self.adjustInvaderMovement(to: self.timePerMove * 0.8)
                    
                    stop.pointee = true
                }
                
            case .downThenLeft:
                proposedMovementDirection = .left
                
                stop.pointee = true
                
            case .downThenRight:
                proposedMovementDirection = .right
                
                stop.pointee = true
                
            default:
                break
            }
            
        }
        
        //7
        if (proposedMovementDirection != invaderMovementDirection) {
            invaderMovementDirection = proposedMovementDirection
        }
    }
    
    // Bullet Helpers
    
    func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: CFTimeInterval, andSoundFileName soundName: String) {
        // 1
        let bulletAction = SKAction.sequence([
            SKAction.move(to: destination, duration: duration),
            SKAction.wait(forDuration: 3.0 / 60.0),
            SKAction.removeFromParent()
            ])
        
        // 3
        bullet.run(bulletAction)
        
        // 4
        addChild(bullet)
    }
    
    func fireQuarkBullets() {
        let existingBullet = childNode(withName: kQuarkFiredBulletName)
        
        // 1
        if existingBullet == nil {
            if let quark = childNode(withName: kQuarkName) {
                let bullet = makeBullet(ofType: .quarkFired)
                // 2
                bullet.position = CGPoint(
                    x: quark.position.x,
                    y: quark.position.y + quark.frame.size.height - bullet.frame.size.height / 2
                )
                // 3
                let bulletDestination = CGPoint(
                    x: quark.position.x,
                    y: frame.size.height + bullet.frame.size.height / 2
                )
                // 4
                fireBullet(
                    bullet: bullet,
                    toDestination: bulletDestination,
                    withDuration: 1.0,
                    andSoundFileName: ""
                )
            }
        }
    }
    
    // User Tap Helpers
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (touch.tapCount == 1) {
                tapQueue.append(1)
            }
        }
    }
    
    // HUD Helpers
    
    // Physics Contact Helpers
    
    func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    func handle(_ contact: SKPhysicsContact) {
        // Ensure you haven't already handled this contact and removed its nodes
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
        if nodeNames.contains(kQuarkName) && nodeNames.contains(kInvaderFiredBulletName) {
            
            // 1
            adjustQuarkHealth(by: -0.334)
            
            if quarkHealth <= 0.0 {
                // 2
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()
            } else {
                // 3
                if let quark = childNode(withName: kQuarkName) {
                    quark.alpha = CGFloat(quarkHealth)
                    
                    if contact.bodyA.node == quark {
                        contact.bodyB.node!.removeFromParent()
                        
                    } else {
                        contact.bodyA.node!.removeFromParent()
                    }
                }
            }
            
        } else if nodeNames.contains(InvaderType.name) && nodeNames.contains(kQuarkFiredBulletName) {
            // Quark bullet hit an invader
            contact.bodyA.node!.removeFromParent()
            contact.bodyB.node!.removeFromParent()
            
            // 4
            adjustScore(by: 100)
        }
    }
    
    // Game End Helpers
    
    func isGameOver() -> Bool {
        // 1
        let invader = childNode(withName: InvaderType.name)
        
        // 2
        var invaderTooLow = false
        
        enumerateChildNodes(withName: InvaderType.name) { node, stop in
            
            if (Float(node.frame.minY) <= self.kMinInvaderBottomHeight)   {
                invaderTooLow = true
                stop.pointee = true
            }
        }
        
        // 3
        let quark = childNode(withName: kQuarkName)
        
        // 4
        return invader == nil || invaderTooLow || quark == nil
    }
    
    func endGame() {
        // 1
        if !gameEnding {
            
            gameEnding = true
            
            // 2
            motionManager.stopAccelerometerUpdates()
            
            // 3
            let gameOverScene: SecondGameOverScene = SecondGameOverScene(size: size)
            
            view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
        }
    }
    
}
