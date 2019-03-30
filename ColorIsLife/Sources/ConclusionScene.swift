//
//  GameScene.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 19/03/2019.
//
import UIKit
import SpriteKit

class ConclusionScene: SKScene {
    var quarkDCImage = SKTexture(imageNamed: "quarkGreen")
    var hintsTextString: String = ""
    // MARK: - Instance Variables
    var camerNode: SKCameraNode?

    var quarkNodeDC: SKNode?

    override func didMove(to view: SKView) {
        
        // MARK: - Instance cameraNode
        self.camerNode = self.childNode(withName: "cameraNode") as? SKCameraNode
        self.camera = camerNode
        
        
        quarkDC()
        GluonDC()
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { timer in
            self.GluonDC2()
        })
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { timer in
            self.GluonTL()
        })
        _ = Timer.scheduledTimer(withTimeInterval: 4.5, repeats: false, block: { timer in
            self.GluonTR()
        })
        createStarLayers()
        circleShape()
    }
    


    func createStarLayers() {
        let background = SKShapeNode(rectOf: frame.size)
        background.fillColor = SKColor.init(red: 9/255, green: 16/255, blue: 49/255, alpha: 1)
        background.zPosition = -1
        background.alpha = 0.6
        self.addChild(background)
        
        //A layer of a star field
        let starfieldNode = SKNode()
        starfieldNode.name = "starfieldNode"
        starfieldNode.zPosition = -2
        starfieldNode.addChild(starfieldEmitterNode(speed: -48, lifetime: size.height / 23, scale: 0.2, birthRate: 1, color: SKColor.lightGray))
        addChild(starfieldNode)
        
        //A second layer of stars
        var emitterNode = starfieldEmitterNode(speed: -32, lifetime: size.height / 10, scale: 0.14, birthRate: 2, color: SKColor.gray)
        emitterNode.zPosition = -10
        starfieldNode.addChild(emitterNode)
        
        //A third layer
        emitterNode = starfieldEmitterNode(speed: -20, lifetime: size.height / 5, scale: 0.1, birthRate: 5, color: SKColor.darkGray)
        starfieldNode.addChild(emitterNode)
    }
    //Creates a new star field
    func starfieldEmitterNode(speed: CGFloat, lifetime: CGFloat, scale: CGFloat, birthRate: CGFloat, color: SKColor) -> SKEmitterNode {
        let star = SKLabelNode(fontNamed: "Helvetica")
        star.fontSize = 80.0
        star.text = "✦"
        let textureView = SKView()
        let texture = textureView.texture(from: star)
        texture!.filteringMode = .nearest
        
        let emitterNode = SKEmitterNode()
        emitterNode.particleTexture = texture
        emitterNode.particleBirthRate = birthRate
        emitterNode.particleColor = color
        emitterNode.particleLifetime = lifetime
        emitterNode.particleSpeed = speed
        emitterNode.particleScale = scale
        emitterNode.zPosition = -1
        emitterNode.particleColorBlendFactor = 1
        emitterNode.position = CGPoint(x: frame.midX, y: frame.maxY)
        emitterNode.particlePositionRange = CGVector(dx: frame.maxX, dy: 0)
        emitterNode.particleSpeedRange = 16.0
        
        //Rotates the stars
        emitterNode.particleAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.rotate(byAngle: CGFloat(-Double.pi/4), duration: 1),
            SKAction.rotate(byAngle: CGFloat(Double.pi/4), duration: 1)]))
        
        //Causes the stars to twinkle
        let twinkles = 20
        let colorSequence = SKKeyframeSequence(capacity: twinkles*2)
        let twinkleTime = 1.0 / CGFloat(twinkles)
        for i in 0..<twinkles {
            colorSequence.addKeyframeValue(SKColor.white,time: CGFloat(i) * 2 * twinkleTime / 2)
            colorSequence.addKeyframeValue(SKColor.blue, time: (CGFloat(i) * 2 + 1) * twinkleTime / 2)
        }
        emitterNode.particleColorSequence = colorSequence
        
        emitterNode.advanceSimulationTime(TimeInterval(lifetime))
        return emitterNode
    }
    
    // MARK: - Creation function for quark (down - center)
    func quarkDC() {
        let quarkDC = SKSpriteNode(texture: quarkDCImage)
        quarkDC.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        quarkDC.xScale = 0.18
        quarkDC.yScale = 0.18
        quarkDC.name = "quarkDC"
        quarkDC.physicsBody?.affectedByGravity = false
        quarkDC.physicsBody?.isDynamic = false
        quarkDC.position = CGPoint(x: 0, y: 0)
        quarkNodeDC = quarkDC
        self.addChild(quarkDC)
        //Runs loops
        quarkDC.run(RotationLoop)
        quarkDC.run(DistortionLoop)
    }
    
    // MARK: - Creation function for gluon (top - right)
    func GluonTR(){
        let gluonNode_TR = SKSpriteNode(imageNamed: "green-magenta")
        gluonNode_TR.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_TR.xScale = 0.10
        gluonNode_TR.yScale = 0.10
        gluonNode_TR.zPosition = 1
        gluonNode_TR.position = CGPoint(x: 150, y: 110)
        gluonNode_TR.physicsBody?.affectedByGravity = false
        gluonNode_TR.physicsBody?.isDynamic = true
        gluonNode_TR.physicsBody?.allowsRotation = true
        gluonNode_TR.name = "gluonTR"
        self.addChild(gluonNode_TR)
        //Runs loops
        gluonNode_TR.run(RotationLoop)
        gluonNode_TR.run(DistortionLoop)
        let circle = UIBezierPath(roundedRect: CGRect(x: (frame.midX) - 200, y: (frame.midY) - 200, width: 400, height: 400), cornerRadius: 200)
        let circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 6)
        let moveLoop = SKAction.repeatForever(circularMove)
        
        gluonNode_TR.run(moveLoop)
    }
    
    // MARK: - Creation function for gluon (top - left)
    func GluonTL(){
        let gluonNode_TL = SKSpriteNode(imageNamed: "green-yellow")
        gluonNode_TL.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_TL.xScale = 0.10
        gluonNode_TL.yScale = 0.10
        gluonNode_TL.zPosition = 1
        gluonNode_TL.position = CGPoint(x: -150, y: 110)  //Middle of Screen
        gluonNode_TL.physicsBody?.affectedByGravity = false
        gluonNode_TL.physicsBody?.isDynamic = true
        gluonNode_TL.physicsBody?.allowsRotation = true
        gluonNode_TL.name = "gluonTL"
        self.addChild(gluonNode_TL)
        //Runs loops
        gluonNode_TL.run(RotationLoop)
        gluonNode_TL.run(DistortionLoop)
        let circle = UIBezierPath(roundedRect: CGRect(x: (frame.midX) - 200, y: (frame.midY) - 200, width: 400, height: 400), cornerRadius: 200)
        let circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 6)
        let moveLoop = SKAction.repeatForever(circularMove)
        
        gluonNode_TL.run(moveLoop)
    }

    // MARK: - Creation function for gluon (down - center)
    func GluonDC(){
        let gluonNode_DC = SKSpriteNode(imageNamed: "red-yellow")
        gluonNode_DC.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_DC.xScale = 0.10
        gluonNode_DC.yScale = 0.10
        gluonNode_DC.zPosition = 1
        gluonNode_DC.position = CGPoint(x: 0, y: -200)  //Middle of Screen
        gluonNode_DC.physicsBody?.affectedByGravity = false
        gluonNode_DC.physicsBody?.isDynamic = true
        gluonNode_DC.physicsBody?.allowsRotation = true
        gluonNode_DC.name = "gluonDC"
        self.addChild(gluonNode_DC)
//        let moveBottomTop = SKAction.move(to: CGPoint(x: 0,y: -100), duration:0.5)
//        gluonNode_DC.run(moveBottomTop)
        //Runs loops
        gluonNode_DC.run(RotationLoop)
        gluonNode_DC.run(DistortionLoop)
        gluonNode_DC.zPosition = 1

        let circle = UIBezierPath(roundedRect: CGRect(x: (frame.midX) - 200, y: (frame.midY) - 200, width: 400, height: 400), cornerRadius: 200)
        let circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 6)
        let moveLoop = SKAction.repeatForever(circularMove)
        
        gluonNode_DC.run(moveLoop)
    }
    // MARK: - Creation function for gluon (down - center)
    func GluonDC2(){
        let gluonNode_DC2 = SKSpriteNode(imageNamed: "red-cyan")
        gluonNode_DC2.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_DC2.xScale = 0.10
        gluonNode_DC2.yScale = 0.10
        gluonNode_DC2.zPosition = 1
        gluonNode_DC2.position = CGPoint(x: 0, y: -200)  //Middle of Screen
        gluonNode_DC2.physicsBody?.affectedByGravity = false
        gluonNode_DC2.physicsBody?.isDynamic = true
        gluonNode_DC2.physicsBody?.allowsRotation = true
        gluonNode_DC2.name = "gluonDC2"
        self.addChild(gluonNode_DC2)
        //        let moveBottomTop = SKAction.move(to: CGPoint(x: 0,y: -100), duration:0.5)
        //        gluonNode_DC.run(moveBottomTop)
        //Runs loops
        gluonNode_DC2.run(RotationLoop)
        gluonNode_DC2.run(DistortionLoop)
        gluonNode_DC2.zPosition = 1
        
        let circle = UIBezierPath(roundedRect: CGRect(x: (frame.midX) - 200, y: (frame.midY) - 200, width: 400, height: 400), cornerRadius: 200)
        let circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: true, duration: 6)
        let moveLoop = SKAction.repeatForever(circularMove)
        
        gluonNode_DC2.run(moveLoop)
    }
    

    func circleShape() {
    let base = SKShapeNode(circleOfRadius: 200 ) // Size of Circle
        base.position = CGPoint(x: frame.midX, y: frame.midY)
    base.lineWidth = 0
    base.fillColor = UIColor(hue:0, saturation:0, brightness:0, alpha:0)
//    base.fillColor = UIColor(hue:1, saturation:0.76, brightness:0.94, alpha:1)
    base.zPosition = 0
    self.addChild(base)
    }
    

}
