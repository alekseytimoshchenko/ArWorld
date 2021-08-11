//
//  SceneObject.swift
//  ArWorld
//
//  Created by aleksey timoshchenko on 11/08/2021.
//

import Foundation
import SceneKit

class SceneObject: SCNNode {
  init(from file: String) {
    super.init()
    let nodesInside = SCNNode.allNodes(from: file)
    nodesInside.forEach { (node) in
      self.addChildNode(node)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
