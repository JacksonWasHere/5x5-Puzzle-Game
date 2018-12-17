//
//  MenuViewController.swift
//  5x5
//
//  Created by Jackson Weidmann on 10/12/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var controller:GameController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SizeViewController {
            dest.controller = self.controller
        }
    }
    
    @IBAction func unwindToMenu(_ sender: UIStoryboardSegue) {
        print(self.controller.game.boardSize)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
