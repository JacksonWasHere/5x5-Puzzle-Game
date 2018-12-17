 //
//  ViewController.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/18/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var controller:GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/2 - 150, width: 300, height: 300)
        self.controller = GameController(frame: rect, onTap:checkSolve)
        controller.game.swapXY(xt: 2, yt: 2)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resetGame() {
        self.controller.frame = CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/2 - 150, width: 300, height: 300)
        self.controller.setup()
    }
    
    func checkSolve() {
        if self.controller.game.isSolved() {
            
            //if solved then create congratulations alert
            let congrats = UIAlertController(title: "Congratulations", message: "You solved the the puzzle", preferredStyle: UIAlertController.Style.alert)
            
            //awesom button
            let awesome = UIAlertAction(title: "Awesome", style: UIAlertAction.Style.cancel, handler: nil)
            
            congrats.addAction(awesome)
            
            //present
            present(congrats, animated: false, completion: nil)
        }
    }
    
    @IBAction func showGame(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {()->Void in
            sender.transform = CGAffineTransform(rotationAngle: .pi/4)
        }, completion: {(Bool)->Void in
            self.view.addSubview(self.controller.game)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let ohNo = UIAlertController(title: "Oh no", message: "what did you do", preferredStyle: UIAlertController.Style.alert)
        
        //awesom button
        let rip = UIAlertAction(title: "I'm Sorry", style: UIAlertAction.Style.cancel, handler: nil)
        
        ohNo.addAction(rip)
        
        //present
        present(ohNo, animated: false, completion: nil)
    }

    @IBAction func mainScreenUnwind(unwindSegue: UIStoryboardSegue) {
        self.controller.frame = CGRect(x: self.view.frame.width/2 - 150, y: self.view.frame.height/2 - 150, width: 300, height: 300)
        self.controller.setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MenuViewController {
            dest.controller = self.controller
        }
    }
}

