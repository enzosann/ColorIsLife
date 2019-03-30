//
//  GameScene.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 19/03/2019.
//
import UIKit
import SpriteKit


// Warp Layer 0
let src0: [float2] = [float2(0.0, 0.0),float2(0.333333, 0.0),float2(0.666667, 0.0),float2(1.0, 0.0),float2(0.0, 0.333333),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(1.0, 0.333333),float2(0.0, 0.666667),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(1.0, 0.666667),float2(0.0, 1.0),float2(0.333333, 1.0),float2(0.666667, 1.0),float2(1.0, 1.0)]
let dst0: [float2] = [float2(0.0, 0.0),float2(0.333333, 0.0),float2(0.661292, 0.0365788),float2(1.0, 0.0),float2(0.0298401, 0.330648),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(1.01686, 0.333201),float2(-0.0290548, 0.668792),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(0.958918, 0.666937),float2(-0.0168422, 1.02452),float2(0.331821, 1.04532),float2(0.680405, 0.961575),float2(1.0, 1.0)]

let grid0: SKWarpGeometryGrid = SKWarpGeometryGrid(columns: 3, rows: 3, sourcePositions: src0, destinationPositions: dst0)

// Warp Layer 1
let src1: [float2] = [float2(0.0, 0.0),float2(0.333333, 0.0),float2(0.666667, 0.0),float2(1.0, 0.0),float2(0.0, 0.333333),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(1.0, 0.333333),float2(0.0, 0.666667),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(1.0, 0.666667),float2(0.0, 1.0),float2(0.333333, 1.0),float2(0.666667, 1.0),float2(1.0, 1.0)]
let dst1: [float2] = [float2(0.0, 0.0),float2(0.315991, 0.0505527),float2(0.682917, -0.0288958),float2(1.0, 0.0),float2(-0.0501579, 0.332917),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(0.957021, 0.336175),float2(0.026529, 0.666896),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(1.0738, 0.677539),float2(0.0, 1.0),float2(0.352959, 0.953419),float2(0.66899, 1.03699),float2(1.0, 1.0)]

let grid1: SKWarpGeometryGrid = SKWarpGeometryGrid(columns: 3, rows: 3, sourcePositions: src1, destinationPositions: dst1)

// Warp Layer 2
let src2: [float2] = [float2(0.0, 0.0),float2(0.333333, 0.0),float2(0.666667, 0.0),float2(1.0, 0.0),float2(0.0, 0.333333),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(1.0, 0.333333),float2(0.0, 0.666667),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(1.0, 0.666667),float2(0.0, 1.0),float2(0.333333, 1.0),float2(0.666667, 1.0),float2(1.0, 1.0)]
let dst2: [float2] = [float2(0.0, 0.0),float2(0.33031, 0.0586047),float2(0.666667, 0.0),float2(1.0, 0.0),float2(0.0, 0.333333),float2(0.333333, 0.333333),float2(0.666667, 0.333333),float2(0.95559, 0.333815),float2(0.0471976, 0.675445),float2(0.333333, 0.666667),float2(0.666667, 0.666667),float2(1.0, 0.666667),float2(0.0, 1.0),float2(0.333333, 1.0),float2(0.686667, 0.940292),float2(1.0, 1.0)]

let grid2: SKWarpGeometryGrid = SKWarpGeometryGrid(columns: 3, rows: 3, sourcePositions: src2, destinationPositions: dst2)


//Applying & Running the actual animation to SKSpritenode ComplShape
//let warpAction = SKAction.warp(to: warpGeometryGrid,duration: 5)
//Applying & Running the actual animation on multiple grids
let warpAction = SKAction.animate(withWarps:[grid0, grid1, grid2, grid0],
                                  times: [0, 0.8, 1.6, 2.4])

//Rotates the sprite over 5 seconds
let ShapeRotation = SKAction.rotate(byAngle: CGFloat(Double.pi), duration:5)

//Sets the rotation and distortion animation to loop
let RotationLoop = SKAction.repeatForever(ShapeRotation)
let DistortionLoop = SKAction.repeatForever(warpAction!)


class GameScene: SKScene, SKPhysicsContactDelegate {
    var quarkDCImage = SKTexture(imageNamed: "quarkRed")
    var quarkTLImage = SKTexture(imageNamed: "quarkGreen")
    var quarkTRImage = SKTexture(imageNamed: "quarkBlue")
    var hintsTextString: String = ""
    // MARK: - Instance Variables
    var camerNode: SKCameraNode?
    private var currentNode: SKNode?
    var gluonNodeTR: SKNode?
    var gluonNodeTL: SKNode?
    var gluonNodeDC: SKNode?
    var quarkTLNode: SKNode?
    var hintsNode: SKNode?
    var hintsShapeNode: SKNode?
    var quarkTLTouched: Bool = false
    var quarkTRTouched: Bool = false
    var quarkDCTouched: Bool = false
    var quarkTRNode: SKNode?
    var quarkDCNode: SKNode?
    var restartNode: SKNode?
    // MARK: - Instance Variables Bitmasks
    struct Bitmask {
        static let gluon = UInt32(1 << 1)
        static let quark = UInt32(1 << 2)
        
    }
    override func didMove(to view: SKView) {
        
        // MARK: - Instance cameraNode
        self.camerNode = self.childNode(withName: "cameraNode") as? SKCameraNode
        self.camera = camerNode
        
        // MARK: - Setting up background
//        scene?.backgroundColor = SKColor.init(red: 9/255, green: 16/255, blue: 49/255, alpha: 1)
        physicsWorld.contactDelegate = self
        
        // MARK: - creation of the child node
        quarkTL()
        quarkTR()
        quarkDC()
        topHintsShape()
        restartButton()
        hintsTextString = "Chose and touch one Quark"
        hintsLabel()
        createStarLayers()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "gluonTL" {
                    self.currentNode = node
                }else if node.name == "gluonTR" {
                    self.currentNode = node
                } else if node.name == "gluonDC" {
                    self.currentNode = node
                } else if node.name == "quarkTL" && quarkTLTouched == false && quarkDCTouched == false {
                    hintsTextString = "Drag the Gluon to the Blue Quark"
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // Set up gluon
                    GluonTL()
                    // change the texture
                    quarkTLImage = SKTexture(imageNamed: "quarkBlue")
                    // MARK: - Remove and insert the Node to update the texture
                    quarkTLNode?.removeFromParent()
                    quarkTL()
                    quarkTLTouched = true
                }  else if node.name == "quarkTL" && quarkTLTouched == false && quarkDCTouched == true && quarkTRTouched == true{
                    hintsTextString =
                    """
                    Oh no, You unbalanced the Color Charge.
                    Restart!
                    """
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // Set up gluon
                    GluonTL()
                    // change the texture
                    quarkTLImage = SKTexture(imageNamed: "quarkBlue")
                    // MARK: - Remove and insert the Node to update the texture
                    quarkTLNode?.removeFromParent()
                    quarkTL()
                    quarkTLTouched = true
                }else if node.name == "quarkTL" && quarkTLTouched == false && quarkDCTouched == true && quarkTRTouched == false{
                    hintsTextString = "Drag the Gluon to the Blue Quark"
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // Set up gluon
                    GluonTL()
                    // change the texture
                    quarkTLImage = SKTexture(imageNamed: "quarkBlue")
                    // MARK: - Remove and insert the Node to update the texture
                    quarkTLNode?.removeFromParent()
                    quarkTL()
                    quarkTLTouched = true
                }else if node.name == "quarkTR" && quarkTRTouched == false{
                    hintsTextString = "it's colorless, nothing will change"
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // Set up gluon1
                    GluonTR()
                    // MARK: - Remove and insert the Node to update the texture
                    quarkTRNode?.removeFromParent()
                    quarkTR()
                    quarkTRTouched = true
                } else if node.name == "quarkDC" && quarkDCTouched == false{
                    hintsTextString = "Now drag it to the Blue Quark"
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // Set up gluon2
                    GluonDC()
                    // change the texture
                    quarkDCImage = SKTexture(imageNamed: "quarkBlue")
                    hintsNode?.removeFromParent()
                    hintsLabel()
                    // MARK: - Remove and insert the Node to update the texture
                    quarkDCNode?.removeFromParent()
                    quarkDC()
                    quarkDCTouched = true
                }else if node.name == "restore" {
                    // restore the texture
                    quarkDCImage = SKTexture(imageNamed: "quarkRed")
                    quarkTLImage = SKTexture(imageNamed: "quarkGreen")
                    quarkTRImage = SKTexture(imageNamed: "quarkBlue")
                    // restore boolean "touched" variables
                    quarkTLTouched = false
                    quarkTRTouched = false
                    quarkDCTouched = false
                    quarkTRNode?.removeFromParent()
                    // Set up gluon
                    quarkTR()
                    quarkTLNode?.removeFromParent()
                    // Set up gluon1
                    quarkTL()
                    quarkDCNode?.removeFromParent()
                    // Set up gluon2
                    quarkDC()
                    gluonNodeTL?.removeFromParent()
                    gluonNodeTR?.removeFromParent()
                    gluonNodeDC?.removeFromParent()
                    hintsTextString = "Chose and touch one Quark"
                    hintsNode?.removeFromParent()
                    hintsLabel()

                }
            }
        }
    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
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
    // MARK: - Creation function for hints label
    func hintsLabel(){
    let hintsText = SKLabelNode(text: hintsTextString)
    hintsText.position = CGPoint(x: 0, y: 292)
    hintsText.fontSize = CGFloat(14)
    hintsText.fontName = "SFProDisplay"
    hintsText.xScale = 1
    hintsText.alpha = 1
    hintsText.zPosition = 1
    hintsText.lineBreakMode = .byCharWrapping
    hintsText.numberOfLines = 2
    hintsNode = hintsText
    hintsText.fontColor = SKColor.white
    hintsText.name = "hintsText"
    self.addChild(hintsText)
    }
    // MARK: - Creation function for restart button
    func restartButton() {
        let restart = SKShapeNode(circleOfRadius: 25)
        restart.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        restart.name = "restore"
        restart.physicsBody?.affectedByGravity = false
        restart.fillColor = SKColor.white
        restart.strokeColor = SKColor.gray
        restart.lineWidth = 0
        restart.fillTexture = SKTexture(imageNamed: "restart")
        restart.position = CGPoint(x: -220, y: 300)
        restart.physicsBody?.collisionBitMask = 0x0
        restartNode = restart
        self.addChild(restart)
    }
    
    // MARK: - Creation function for quark (top - left)
    func quarkTL() {
        let quarkTL = SKSpriteNode(texture: quarkTLImage)
        quarkTL.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        quarkTL.xScale = 0.18
        quarkTL.yScale = 0.18
        quarkTL.name = "quarkTL"
        quarkTL.physicsBody?.affectedByGravity = false
        quarkTL.physicsBody?.isDynamic = false
        quarkTL.position = CGPoint(x: -200, y: 200)
        quarkTL.physicsBody?.categoryBitMask = Bitmask.quark
        quarkTL.physicsBody?.contactTestBitMask = Bitmask.gluon | Bitmask.quark
        quarkTL.physicsBody?.collisionBitMask = 0
        quarkTL.physicsBody?.usesPreciseCollisionDetection = true
        quarkTLNode = quarkTL
        self.addChild(quarkTL)
        //Runs loops
        quarkTL.run(RotationLoop)
        quarkTL.run(DistortionLoop)
    }
    
    // MARK: - Creation function for quark (top - right)
    func quarkTR() {
        let quarkTR = SKSpriteNode(texture: quarkTRImage)
        quarkTR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        quarkTR.xScale = 0.18
        quarkTR.yScale = 0.18
        quarkTR.name = "quarkTR"
        quarkTR.physicsBody?.affectedByGravity = false
        quarkTR.physicsBody?.isDynamic = false
        quarkTR.position = CGPoint(x: 200, y: 200)
        quarkTR.physicsBody?.categoryBitMask = Bitmask.quark
        quarkTR.physicsBody?.contactTestBitMask = Bitmask.gluon | Bitmask.quark
        quarkTR.physicsBody?.collisionBitMask = 0
        quarkTR.physicsBody?.usesPreciseCollisionDetection = true
        quarkTRNode = quarkTR
        self.addChild(quarkTR)
        //Runs loops
        quarkTR.run(RotationLoop)
        quarkTR.run(DistortionLoop)
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
        quarkDC.position = CGPoint(x: 0, y: -200)
        quarkDC.physicsBody?.categoryBitMask = Bitmask.quark
        quarkDC.physicsBody?.contactTestBitMask = Bitmask.gluon | Bitmask.quark
        quarkDC.physicsBody?.collisionBitMask = 0
        quarkDC.physicsBody?.usesPreciseCollisionDetection = true
        quarkDCNode = quarkDC
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
        gluonNode_TR.position = CGPoint(x: 180, y: 160)
        gluonNode_TR.physicsBody?.affectedByGravity = false
        gluonNode_TR.physicsBody?.isDynamic = true
        gluonNode_TR.physicsBody?.categoryBitMask = Bitmask.gluon
        gluonNode_TR.physicsBody?.contactTestBitMask = Bitmask.quark | Bitmask.gluon
        gluonNode_TR.physicsBody?.collisionBitMask = 1
        gluonNode_TR.physicsBody?.allowsRotation = true
        gluonNode_TR.physicsBody?.usesPreciseCollisionDetection = true
        gluonNode_TR.name = "gluonTR"
        gluonNodeTR = gluonNode_TR
        self.addChild(gluonNode_TR)
        let moveBottomLeft = SKAction.move(to: CGPoint(x: 150,y: 110), duration:0.5)
        gluonNode_TR.run(moveBottomLeft)
        //Runs loops
        gluonNode_TR.run(RotationLoop)
        gluonNode_TR.run(DistortionLoop)
    }
    
    // MARK: - Creation function for gluon (top - left)
    func GluonTL(){
        let gluonNode_TL = SKSpriteNode(imageNamed: "green-yellow")
        gluonNode_TL.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_TL.xScale = 0.10
        gluonNode_TL.yScale = 0.10
        gluonNode_TL.position = CGPoint(x: -180, y: 160)  //Middle of Screen
        gluonNode_TL.physicsBody?.affectedByGravity = false
        gluonNode_TL.physicsBody?.isDynamic = true
        gluonNode_TL.physicsBody?.categoryBitMask = Bitmask.gluon
        gluonNode_TL.physicsBody?.contactTestBitMask = Bitmask.quark | Bitmask.gluon
        gluonNode_TL.physicsBody?.collisionBitMask = 1
        gluonNode_TL.physicsBody?.allowsRotation = true
        gluonNode_TL.physicsBody?.usesPreciseCollisionDetection = true
        gluonNode_TL.name = "gluonTL"
        gluonNodeTL = gluonNode_TL
        self.addChild(gluonNode_TL)
        let moveBottomRight = SKAction.move(to: CGPoint(x: -150,y: 110), duration:0.5)
        gluonNode_TL.run(moveBottomRight)
        //Runs loops
        gluonNode_TL.run(RotationLoop)
        gluonNode_TL.run(DistortionLoop)
    }
    
    // MARK: - Creation function for gluon (down - center)
    func GluonDC(){
        let gluonNode_DC = SKSpriteNode(imageNamed: "red-yellow")
        gluonNode_DC.physicsBody = SKPhysicsBody(circleOfRadius: 10) // Size of Circle
        gluonNode_DC.xScale = 0.10
        gluonNode_DC.yScale = 0.10
        gluonNode_DC.position = CGPoint(x: 0, y: -160)  //Middle of Screen
        gluonNode_DC.physicsBody?.affectedByGravity = false
        gluonNode_DC.physicsBody?.isDynamic = true
        gluonNode_DC.physicsBody?.categoryBitMask = Bitmask.gluon
        gluonNode_DC.physicsBody?.contactTestBitMask = Bitmask.quark | Bitmask.gluon
        gluonNode_DC.physicsBody?.collisionBitMask = 1
        gluonNode_DC.physicsBody?.allowsRotation = true
        gluonNode_DC.physicsBody?.usesPreciseCollisionDetection = true
        gluonNode_DC.name = "gluonDC"
        gluonNodeDC = gluonNode_DC
        self.addChild(gluonNode_DC)
        let moveBottomTop = SKAction.move(to: CGPoint(x: 0,y: -100), duration:0.5)
        gluonNode_DC.run(moveBottomTop)
        //Runs loops
        gluonNode_DC.run(RotationLoop)
        gluonNode_DC.run(DistortionLoop)
    }
    
    func topHintsShape(){
        let hintsShape = SKSpriteNode(imageNamed: "labelBack")
        hintsShape.xScale = 0.6
        hintsShape.yScale = 0.6
        hintsShape.alpha = 0.8
        hintsShape.position = CGPoint(x: 0, y: 300)
        hintsShape.physicsBody?.affectedByGravity = false
        hintsShape.physicsBody?.isDynamic = false
        hintsShape.name = "hintsShape"
        hintsShapeNode = hintsShape
        self.addChild(hintsShape)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // 2. Assign the two physics bodies so that the one with the
        // highest category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between the two nodes
        if firstBody.node?.name == "gluonTL" && secondBody.node?.name == "quarkTR" && quarkDCTouched == false && quarkTLTouched == false{
            gluonNodeTL?.removeFromParent()
            quarkTRImage = SKTexture(imageNamed: "quarkGreen")
            quarkTRNode?.removeFromParent()
            quarkTR()
            hintsTextString = "Now click the Red Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonTL" && secondBody.node?.name == "quarkDC" && quarkDCTouched == true && quarkTRTouched == false{
            gluonNodeTL?.removeFromParent()
            quarkDCImage = SKTexture(imageNamed: "quarkGreen")
            quarkDCNode?.removeFromParent()
            quarkDC()
            hintsTextString = "Now click the Red Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonTL" && secondBody.node?.name == "quarkTR" && quarkDCTouched == false && quarkTRTouched == false{
            gluonNodeTL?.removeFromParent()
            quarkTRImage = SKTexture(imageNamed: "quarkGreen")
            quarkTRNode?.removeFromParent()
            quarkTR()
            hintsTextString = "Now click the Red Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonTL" && secondBody.node?.name == "quarkTR" && quarkDCTouched == false && quarkTRTouched == true{
            gluonNodeTL?.removeFromParent()
            quarkTRImage = SKTexture(imageNamed: "quarkGreen")
            quarkTRNode?.removeFromParent()
            quarkTR()
            hintsTextString = "Now click the Red Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonDC" && secondBody.node?.name == "quarkTL" && quarkDCTouched == true && quarkTLTouched == false{
            gluonNodeDC?.removeFromParent()
            quarkTLNode?.removeFromParent()
            quarkTLImage = SKTexture(imageNamed: "quarkRed")
            quarkTL()
            hintsTextString = "Now click the Green Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonDC" && secondBody.node?.name == "quarkTL" && quarkDCTouched == true && quarkTLTouched == true && quarkTRTouched == true{
            gluonNodeDC?.removeFromParent()
            quarkTLNode?.removeFromParent()
            quarkTLImage = SKTexture(imageNamed: "quarkRed")
            quarkTL()
            hintsTextString = "Congrats!"
            hintsNode?.removeFromParent()
            hintsLabel()
        } else if firstBody.node?.name == "gluonDC" && secondBody.node?.name == "quarkTL" && quarkDCTouched == true && quarkTLTouched == true{
            gluonNodeDC?.removeFromParent()
            quarkTLNode?.removeFromParent()
            quarkTLImage = SKTexture(imageNamed: "quarkRed")
            quarkTL()
            hintsTextString = "Now click the Green Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        } else if firstBody.node?.name == "gluonTR" && secondBody.node?.name == "quarkTL" && quarkDCTouched == true && quarkTLTouched == true && quarkTRTouched == true || firstBody.node?.name == "gluonTR" && secondBody.node?.name == "quarkDC" && quarkDCTouched == true && quarkTLTouched == true && quarkTRTouched == true{
            gluonNodeTR?.removeFromParent()
            hintsTextString = "Congrats!"
            hintsNode?.removeFromParent()
            hintsLabel()
        }else if firstBody.node?.name == "gluonTR" && secondBody.node?.name == "quarkDC" && quarkDCTouched == false && quarkTLTouched == false{
            gluonNodeTR?.removeFromParent()
            hintsTextString = "Now click the Green Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }  else if firstBody.node?.name == "gluonTR" && secondBody.node?.name == "quarkTL" && quarkDCTouched == false && quarkTRTouched == true || firstBody.node?.name == "gluonTR" && secondBody.node?.name == "quarkDC" && quarkDCTouched == true && quarkTLTouched == false{
            gluonNodeTR?.removeFromParent()
            hintsTextString = "Now click the Red Quark!"
            hintsNode?.removeFromParent()
            hintsLabel()
        } else if firstBody.node?.name == "gluonDC" && secondBody.node?.name == "quarkTR" && quarkTLTouched == false && quarkDCTouched == true{
            gluonNodeDC?.removeFromParent()
            quarkTRNode?.removeFromParent()
            quarkTRImage = SKTexture(imageNamed: "quarkRed")
            quarkTR()
            hintsTextString = "Now click the Green Quark"
            hintsNode?.removeFromParent()
            hintsLabel()
        }
    }
}
