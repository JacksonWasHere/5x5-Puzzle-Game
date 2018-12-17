//
//  Game.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/18/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class Game: UIView {
    
    //array of buttons
    var gameButtons = [[UIButton]]()
    var buttonSize:Int!
    var moveShape:Shape!
    //location of the tap in the move shape
    var tapLocation = CGPoint(x: 0, y: 0)
    var boardSize:CGSize!
    //what to do when you tap (this is a closure)
    var tapFunc:(()->(Void))?
    //the colors of solved and unsolved
    var onColor = UIColor(red: 0/255, green: 255/255, blue: 158/255, alpha: 1)
    var offColor = UIColor(red: 20/255, green: 0/255, blue: 129/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //create the default board
        boardSize = CGSize(width: 5, height: 5)
        buttonSize = Int(self.frame.width/boardSize.width)
        setup()
    }
    
    init(frame: CGRect, game: Int,onTap: @escaping (()->(Void))) {
        super.init(frame: frame)
        //create board using game and add the ontap function
        boardSize = CGSize(width: game, height: game)
        buttonSize = Int(self.frame.width/boardSize.width)
        tapFunc = onTap
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func setup() {
        //reset gameButtons and clear all subviews
        gameButtons = [[UIButton]]()
        buttonSize = Int(self.frame.width/boardSize.width)
        while let subviews = self.subviews.last {
            subviews.removeFromSuperview()
        }
        
        //loop through all the buttons
        for x in 0..<Int(boardSize.width) {
            var row = [UIButton]()
            
            for y in 0..<Int(boardSize.height) {
                
                //create the frame for the button
                let rect = CGRect(x: x * buttonSize, y: y * buttonSize, width: buttonSize, height: buttonSize)
                
                //create the button with the frame and modify the button
                let button = UIButton(frame: rect)
                button.backgroundColor = offColor
                button.addTarget(self, action: #selector(swap), for: .touchUpInside)
                button.layer.borderWidth = 4
                button.layer.borderColor = UIColor(red: 227/255, green: 255/255, blue: 248/255, alpha: 1).cgColor
                self.addSubview(button)
                //add this button
                row.append(button)
            }
            //this row
            gameButtons.append(row)
        }
    }
    
    @objc func swap(_ sender: UIButton) {
        //find the tap location
        let xtap = Int(sender.frame.origin.x)/buttonSize
        let ytap = Int(sender.frame.origin.y)/buttonSize
        //swap at the tap location
        swapXY(xt: xtap, yt: ytap)
        //call the function that is done when tapped
        if let fun = tapFunc {
            fun()
        }
    }
    
    func swapXY(xt:Int,yt:Int) {
        //loop through the move shape
        for x in 0..<moveShape.shapeArray.count {
            for y in 0..<moveShape.shapeArray[x].count {
                //see if it should be swapped
                if moveShape.shapeArray[x][y]==1{
                    
                    //find the x and y to swap
                    let xswap = x + (yt + Int(tapLocation.x)) - 1
                    let yswap = y + (xt + Int(tapLocation.y)) - 1
                    
                    //swap if it is in bounds
                    if xswap>=0 && xswap<Int(boardSize.width) && yswap>=0 && yswap<Int(boardSize.height) {
                        //find the color and swap it
                        let color = gameButtons[yswap][xswap].backgroundColor
                        gameButtons[yswap][xswap].backgroundColor = color==offColor ? onColor : offColor
                    }
                }
            }
        }
    }
    
    func isSolved() -> Bool {
        //loop through all buttons and return true if they are all green
        for row in gameButtons {
            for button in row {
                if button.backgroundColor == offColor {
                    return false
                }
            }
        }
        return true
    }

}
