//
//  GameController.swift
//  5x5
//
//  Created by Jackson Weidmann on 10/16/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit
class GameController {
    var game:Game!
    var shapes = ShapeController()
    var size = 5
    var frame:CGRect!
    init(frame: CGRect,onTap: @escaping (()->(Void))) {
        self.frame = frame
        game = Game(frame: frame, game: size, onTap: onTap)
        game.moveShape = shapes.getActive()
    }
    
    func setShape(name: String) {
        shapes.activeShape = name
    }
    
    func resetSize(size: Int) {
        self.size = size
    }
    
    func setup() {
        game.frame = self.frame
        game.boardSize = CGSize(width:size,height:size)
        game.moveShape = shapes.getActive()
        game.setup()
    }
    
    func whenPressed() {
        
    }
}
