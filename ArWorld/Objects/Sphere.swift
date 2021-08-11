//
//  Sphere.swift
//  ArWorld
//
//  Created by aleksey timoshchenko on 11/08/2021.
//

import Foundation
import SceneKit

class Sphere: SceneObject {
  var animating: Bool = false
  let patrolDistance: Float = 4.85
  
  init() {
    super.init(from: "sphere.dae")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func animate() {
    if animating { return }
    
    animating = true
    
    let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.random(min: -Float.pi, max: Float.pi)), z: 0, duration: 5.0)
    let backwards = rotateOne.reversed()
    let rotateSequence = SCNAction.sequence([rotateOne, backwards])
    
    let hoverUp = SCNAction.moveBy(x: 0, y: 1, z: 0, duration: 2.5)
    let hoverDown = SCNAction.moveBy(x: 0, y: -1, z: 0, duration: 2.5)
    let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
    
    let rotateAndHover = SCNAction.group([rotateSequence, hoverSequence])
    let repeatForever = SCNAction.repeatForever(rotateAndHover)
    
    runAction(repeatForever)
  }
  
  func patrol(targetPos: SCNVector3) {
    let distanceToTarget = targetPos.distance(receiver: self.position)
    
    if distanceToTarget < patrolDistance {
      removeAllActions()
      animating = false
      SCNTransaction.begin()
      SCNTransaction.animationDuration = 0.20
      look(at: targetPos)
      SCNTransaction.commit()
    } else {
      if !animating {
        animate()
      }
    }
  }
}
