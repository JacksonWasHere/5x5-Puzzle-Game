 //
//  ViewController.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/18/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var shape = ShapeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(shape.getActive().title)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(shape.getActive().title)
        
        //check if the sender is a button
        guard let button = sender as? UIButton else {
            fatalError("Bad Button")
        }
        
        //if the destination is a gameviewcontroller
        if let gamePage = segue.destination as? GameViewController {
            
            //default size is 1 and it is not custom
            var size = 1
            var custom = false
            
            if button.titleLabel?.text == "Custom Size" {
                //if the title says custom then size is 5 by default and it is custom
                size = 5
                custom = true
                print("is custom")
            } else {
                //else size is the first character in the label
                size = Int(String((button.titleLabel?.text?.first!)!))!
            }
            //the shape is active shape, boardSize is size, custom is custom
            gamePage.shape = self.shape.getActive()
            gamePage.boardSize = size
            gamePage.custom = custom
        }
        // if it is a shape selector then set the controller as the current controller
        if let shapeSelect = segue.destination as? ShapeSelectorViewController {
            shapeSelect.shapeSelection = self.shape
        }
    }
}

