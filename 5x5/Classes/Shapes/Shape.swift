//
//  Shape.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/20/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import Foundation
import UIKit
class Shape {
    var title:String!
    //if the shape is allowed to be used (for in app purchases)
    var locked = false
    var size = 0
    var tapLocation = CGPoint(x: 0, y: 0)
    var shapeArray = [[Int]]()
    
    init(title:String, locked: Bool,size: Int, shapeArray:[[Int]]) {
        self.title = title
        self.locked = locked
        self.size = shapeArray.count
        self.shapeArray = shapeArray
    }
}
