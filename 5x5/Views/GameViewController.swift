//
//  GameViewController.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/18/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: UIViewController {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    var buttonView:Game!
    var boardSize = 1
    var custom = false
    var shape:Shape!
    
    override func viewDidLoad() {
        //create the game rectangle
        let rect = CGRect(x: 10, y: 74, width: self.view.frame.width - 20, height: self.view.frame.width - 20)
        
        if custom {
            //create an alert if size is custom
            let alert = UIAlertController(title: "Input Size", message: "This will make a square with these dimensions", preferredStyle: UIAlertControllerStyle.alert)
            
            //add the text field with the keyboard as a number pad
            alert.addTextField(configurationHandler: {(textField) in
                textField.keyboardType = UIKeyboardType.numberPad
            })
            
            //add the action when 'OK' is pressed
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action) in
                if alert.textFields![0].text!=="0" {
                    alert.textFields![0].text!=""
                }
                if let newSize = Int(alert.textFields![0].text!){
                    //set the size if newSize isn't nil
                    self.boardSize = newSize
                } else {
                    //if it is not then tell them and set size to 5
                    let invalidAlert = UIAlertController(title: "Invalid", message: "you must enter a number", preferredStyle: UIAlertControllerStyle.alert)
                    invalidAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: {(alert) in return }))
                    
                    //present the invalid number alert
                    self.present(invalidAlert, animated: false, completion: nil)
                    self.boardSize = 5
                }
                
                //set the view to a new game with the rect, size, and action upon tap
                self.buttonView = Game(frame: rect, game: self.boardSize, onTap: self.checkSolve)
                
                //add view and set the shape
                self.view.addSubview(self.buttonView)
                self.buttonView.moveShape = self.shape
                print(self.boardSize)
            }))
            
            //present the size input
            present(alert, animated: false, completion: nil)
        }
        else {
            //if not custom then create the game with same parameters
            buttonView = Game(frame: rect,game: boardSize, onTap: checkSolve)
            buttonView.setup()
            buttonView.moveShape = self.shape
            self.view.addSubview(buttonView)
        }
        
        self.title = "Size: \(self.boardSize)x\(self.boardSize)"
        
        //add the reset and random buttons' targets
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(scramble), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reset() {
        //setup the view if reset is pressed
        buttonView.setup()
    }
    
    @objc func scramble() {
        //make a random move for half the size of the board
        for _ in 0..<Int(buttonView.boardSize.width*buttonView.boardSize.height/2){
            buttonView.swapXY(xt: Int(arc4random_uniform(UInt32(boardSize))), yt: Int(arc4random_uniform(UInt32(boardSize))))
        }
    }
    
    func checkSolve() {
        if buttonView.isSolved() {
            
            //if solved then create congratulations alert
            let congrats = UIAlertController(title: "Congratulations", message: "You solved the the puzzle", preferredStyle: UIAlertControllerStyle.alert)
            
            //awesom button
            let awesome = UIAlertAction(title: "Awesome", style: UIAlertActionStyle.cancel, handler: nil)
            
            congrats.addAction(awesome)
            
            //present
            present(congrats, animated: false, completion: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if let destination = segue.destination as? ShapeSelectorViewController {
//            destination.shapeSelection = self.shape
//        }
    }

}
