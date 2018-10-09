//
//  ShapeSelectorViewController.swift
//  5x5
//
//  Created by Jackson Weidmann on 8/19/18.
//  Copyright © 2018 Jackson Weidmann. All rights reserved.
//

import UIKit

class ShapeSelectorViewController: UIViewController {

    var scrollView:UIScrollView!
    var choiceView:UIView!
    var shapeSelection:ShapeController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Initialize the view that holds our choices
        choiceView = UIView(frame: CGRect(x: 0, y: 0, width: Int(view.frame.width), height: 10 + Int(self.view.frame.width-150) * shapeSelection.shapeTypes.count))
        createChoiceView()

        //create the scroll view
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.white
        scrollView.contentSize = choiceView.frame.size
        scrollView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))

        //add everything to the view
        scrollView.addSubview(choiceView)
        view.addSubview(scrollView)
    }
    
    func createChoiceView() {
        //create array of buttons then add them to the view
        var array = [UIButton]()
        
        for name in shapeSelection.shapes {
            array.append(createButton(buttonArray: array,name: name.title))
        }
        for item in array {
            print(item)
            choiceView.addSubview(item)
        }
    }
    
    func createButton(buttonArray: [UIButton],name: String) -> UIButton {
        //create the button with the proper dimensions
        let button = UIButton(frame: CGRect(x: 10, y: 10 + buttonArray.count * Int(self.view.frame.width-150), width: Int(self.view.frame.width-20), height: Int(self.view.frame.width-160)))
        
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 6

        //set the title and make the button selected if it is the current shape
        button.setTitle(name, for: .normal)
        if name == shapeSelection.getActive().title {
            button.setTitleColor(UIColor.blue, for: .normal)
            button.layer.borderColor = UIColor.blue.cgColor
        } else {
            button.setTitleColor(UIColor.black, for: .normal)
            button.layer.borderColor = UIColor.black.cgColor
        }

        button.backgroundColor = UIColor.white
        
        //perform selected action when tapped
        button.addTarget(self, action: #selector(selected), for: .touchUpInside)
        return button
    }
    
    @objc func selected(_ sender: UIButton) {
        
        //find the view that is the selected button
        if let button = choiceView.subviews.first(where: {(view) -> Bool in
            //see if view is a button
            if let button = view as? UIButton{
                return button.titleLabel?.text == shapeSelection.getActive().title
            }
            return false
        }) as? UIButton {
            //set it's colors to normal
            button.layer.borderColor = UIColor.black.cgColor
            button.setTitleColor(.black, for: .normal)
        }
        //set the sender to selected
        sender.layer.borderColor = UIColor.blue.cgColor
        sender.setTitleColor(.blue, for: .normal)
        shapeSelection.activeShape = (sender.titleLabel?.text)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
