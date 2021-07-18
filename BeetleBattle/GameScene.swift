//
//  GameScene.swift
//  BeetleBattle
//
//  Created by Wonshik KIM on 2021/07/17.
//

import SpriteKit
import GameplayKit

enum Direction {
  case left
  case right
  case top
  case bottom
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    
    let beetle = SKSpriteNode(imageNamed: "beetle1")
    let ball = SKSpriteNode(imageNamed: "ball1")
    
    private var beetleDirection: Direction = Direction.bottom
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        let ballAnimation = SKAction.animate(with: [SKTexture(imageNamed: "ball1"), SKTexture(imageNamed: "ball2")], timePerFrame: 0.1)
        ball.run(SKAction.repeatForever(ballAnimation));
        
        // let beetleTexture = SKTextureAtlas(named: "beetle")
        var textures:[SKTexture] = []
        for i in 1...4 {
            textures.append(SKTexture(imageNamed: "beetle\(i)"))
        }
        let beetleAnimation: SKAction = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        beetle.xScale = 3.0
        beetle.yScale = 3.0
        beetle.run(SKAction.repeatForever(beetleAnimation))
        
        self.addChild(beetle)
    }
    
    override func keyDown(with event: NSEvent) {
        print(beetle.position)
        print(self.size)
        
        switch event.keyCode {
        case 0x31: // spacebar
//            if let label = self.label {
//                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//            }
            if let n = self.ball.copy() as! SKSpriteNode? {
                n.position = beetle.position
                
                switch beetleDirection {
                case Direction.left:
                    n.run(SKAction.sequence([SKAction.moveTo(x: -512, duration: 0.1),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
                    break
                case Direction.right:
                    n.run(SKAction.sequence([SKAction.moveTo(x: 512, duration: 0.1),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
                    break
                case Direction.top:
                    n.run(SKAction.sequence([SKAction.moveTo(y: 384, duration: 0.1),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
                    break
                case Direction.bottom:
                    n.run(SKAction.sequence([SKAction.moveTo(y: -384, duration: 0.1),
                                             SKAction.fadeOut(withDuration: 0.5),
                                             SKAction.removeFromParent()]))
                    break
                }
                
                self.addChild(n)
            }
        case 0x7b: // left
            var multiplier = 0.0
            if beetleDirection == Direction.top {
                multiplier = 1.0
            }
            if beetleDirection == Direction.bottom {
                multiplier = -1.0
            }
            if (beetleDirection == Direction.right) {
                multiplier = 2.0
            }
            if beetleDirection != Direction.left {
                beetle.run(SKAction.rotate(byAngle: CGFloat(multiplier * (.pi / 2)), duration: 0.1));
            }
            
            beetle.position = CGPoint(x: beetle.position.x - 20, y: beetle.position.y)
            beetleDirection = Direction.left
            break
        case 0x7c: // right
            var multiplier = 0.0
            if beetleDirection == Direction.top {
                multiplier = -1.0
            }
            if beetleDirection == Direction.bottom {
                multiplier = 1.0
            }
            if (beetleDirection == Direction.left) {
                multiplier = 2.0
            }
            if beetleDirection != Direction.right {
                beetle.run(SKAction.rotate(byAngle: CGFloat(multiplier * (.pi / 2)), duration: 0.1));
            }
            
            beetle.position = CGPoint(x: beetle.position.x + 20, y: beetle.position.y)
            beetleDirection = Direction.right
            break
        case 0x7d: // bottom
            var multiplier = 0.0
            if beetleDirection == Direction.left {
                multiplier = 1.0
            }
            if beetleDirection == Direction.right {
                multiplier = -1.0
            }
            if (beetleDirection == Direction.top) {
                multiplier = 2.0
            }
            if beetleDirection != Direction.bottom {
                beetle.run(SKAction.rotate(byAngle: CGFloat(multiplier * (.pi / 2)), duration: 0.1));
            }
            
            beetle.position = CGPoint(x: beetle.position.x, y: beetle.position.y - 20)
            beetleDirection = Direction.bottom
            break
        case 0x7e: // top
            var multiplier = 0.0
            if beetleDirection == Direction.left {
                multiplier = -1.0
            }
            if beetleDirection == Direction.right {
                multiplier = 1.0
            }
            if (beetleDirection == Direction.bottom) {
                multiplier = 2.0
            }
            if beetleDirection != Direction.top {
                beetle.run(SKAction.rotate(byAngle: CGFloat(multiplier * (.pi / 2)), duration: 0.1));
            }
            
            beetle.position = CGPoint(x: beetle.position.x, y: beetle.position.y + 20)
            beetleDirection = Direction.top
            break
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
