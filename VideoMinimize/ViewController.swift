//
//  ViewController.swift
//  VideoMinimize
//
//  Created by Stanley Pan on 23/11/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swipeMinimizeView: SwipeMinimizeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        swipeMinimizeView.configureSizeAndPosition(self.view.frame)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
