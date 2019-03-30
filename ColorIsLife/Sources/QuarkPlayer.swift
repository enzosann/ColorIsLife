//
//  QuarkPlayer.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 23/03/2019.
//

import Foundation
import SpriteKit

class quarkPlayer: SKNode {
    init(image: SKSpriteNode) {
        
        var imageSize = image.size
        imageSize = CGSize(width: 80, height: 80)
        super.init()
        
//        set the size and starting point
        self.position = CGPoint(x: 100, y: 100)
        self.xScale = 0.15
        self.yScale = 0.15
        
//       apply a physics body to the node
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "quarkBlue"), size: imageSize)
        
//        set the bitmask properties
        self.physicsBody?.categoryBitMask = playerCategory
        self.physicsBody?.contactTestBitMask = RainFallCategory
        self.physicsBody?.collisionBitMask = playerCategory
        self.physicsBody?.affectedByGravity = false
//        add the image in the object
        self.addChild(image)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has nit been implemented")
    }
    
//    enables the ability to drag the person along the x axis
    func move(touchLocation: CGPoint) {
        if self.calculateAccumulatedFrame().contains(touchLocation){
            self.position.x = touchLocation.x
        }
    }
}
