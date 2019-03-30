//
//  Floor.swift
//  Book_Sources
//
//  Created by Vincenzo Sannino on 23/03/2019.
//

import Foundation
import SpriteKit


class Floor: SKNode {
    
    override init() {
        super.init()
//        set the size and position of the node
        self.position = CGPoint(x: 0, y: -UIScreen.main.bounds.height / 2)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width * 2, height: 20))
        
//        apply a physics body to the node
        self.physicsBody?.isDynamic = false
        
//        set the bitmask properties
        self.physicsBody?.categoryBitMask = floorCategory
        self.physicsBody?.contactTestBitMask = RainFallCategory
        self.physicsBody?.collisionBitMask = playerCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
