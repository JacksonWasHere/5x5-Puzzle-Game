//
//  ShapeController.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/20/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import Foundation

class ShapeController {
    var shapeTypes = [
            "Cross":[
                [0,1,0],
                [1,1,1],
                [0,1,0]
            ],
            "X":[
                [1,0,1],
                [0,1,0],
                [1,0,1]
            ],
            "Line":[
                [0,1,0],
                [0,1,0],
                [0,1,0]
            ],
            "T Shape":[
                [1,1,1],
                [0,1,0],
                [0,1,0]
            ],
            "I Shape":[
                [1,1,1],
                [0,1,0],
                [1,1,1]
            ],
            "Diagonal":[
                [1,0,0],
                [0,1,0],
                [0,0,1]
            ],
            "Hallow Cross":[
                [0,1,0],
                [1,0,1],
                [0,1,0]
            ]
        ]
    
    //the active shape and a list of shapes in order
    var activeShape = "Cross"
    var shapeOrder = ["Cross","X","Hallow Cross","Line","Diagonal","I Shape","T Shape"]
    var shapes = [Shape]()
    
    init() {
        
        //loop through shapes in order
        for key in shapeOrder {
            
            //get the shape array
            let value = shapeTypes[key]!
            
            //add a shape with these properties
            let newShape = Shape(title: key, locked: false, size: 3, shapeArray: value)
            addShape(shape: newShape)
        }
    }
    
    func addShape(shape: Shape) {
        shapes.append(shape)
    }
    
//    func getIndex(index:Int) -> Shape {
//        return shapes[0]
//    }
    
    func getActive() -> Shape {
        //return the first shape that has a title equal to the current shape
        return shapes.first(where: {(shape) -> Bool in
            return shape.title==activeShape
        })!
    }
}
