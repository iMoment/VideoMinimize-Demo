//
//  SwipeMinimizeView.swift
//  VideoMinimize
//
//  Created by Stanley Pan on 23/11/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

class SwipeMinimizeView: UIView {
    
    var startingCenter: CGPoint?
    var finalCenter: CGPoint?
    var startingSize: CGSize?
    var finalSize: CGSize?
    let aspectRatio: CGFloat = 0.5625
    
    var rangeTotal: CGFloat!
    var widthRange: CGFloat!
    var centerXRange: CGFloat!
    
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
    
    func configureSizeAndPosition(_ parentViewFrame: CGRect) {
        
        self.startingCenter = self.center
        self.finalCenter = CGPoint(x: parentViewFrame.size.width - parentViewFrame.size.width/4, y: parentViewFrame.size.height - (self.frame.size.height/4) - 2)
        
        startingSize = self.frame.size
        finalSize = CGSize(width: parentViewFrame.size.width/2 - 10, height: (parentViewFrame.size.width/2 - 10) * aspectRatio)
        
        // Set common range totals once
        rangeTotal = finalCenter!.y - startingCenter!.y
        widthRange = startingSize!.width - finalSize!.width
        centerXRange = finalCenter!.x - startingCenter!.x
    }
}






