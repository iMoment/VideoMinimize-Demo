//
//  SwipeMinimizeView.swift
//  VideoMinimize
//
//  Created by Stanley Pan on 23/11/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SwipeMinimizeView: UIView {
    
    // Called when making view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Called when creating view from Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func initializeGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanning))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
    }
    
    func handlePanning() {
        
    }
}






