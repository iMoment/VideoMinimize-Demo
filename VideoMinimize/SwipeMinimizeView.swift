//
//  SwipeMinimizeView.swift
//  VideoMinimize
//
//  Created by Stanley Pan on 23/11/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit

// MARK: Comparison operators with optionals removed from Swift Standard Libary
// Copy/pasted from previous projects converted to Swift 3 to save time.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// MARK: Comparison operators with optionals removed from Swift Standard Libary
// Copy/pasted from previous projects converted to Swift 3 to save time.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

class SwipeMinimizeView: UIView, UIGestureRecognizerDelegate {
    
    // Mark: View Properties
    var startingCenter: CGPoint?
    var finalCenter: CGPoint?
    var startingSize: CGSize?
    var finalSize: CGSize?
    let aspectRatio: CGFloat = 0.5625 // This is 16:9 in decimal form
    
    var rangeTotal: CGFloat!
    var widthRange: CGFloat!
    var centerXRange: CGFloat!
    
    // Called when making view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeGesture()
    }
    
    // Called when creating view from Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeGesture()
    }

    // Initialize PanGesture properties
    func initializeGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanning))
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGesture)
    }
    
    // Configure swipeMinimizeView
    func configureSizeAndPosition(_ parentViewFrame: CGRect) {
        
        // Set starting and final center of swipeMinimizeView
        self.startingCenter = self.center
        self.finalCenter = CGPoint(x: parentViewFrame.size.width - parentViewFrame.size.width/4,
                                   y: parentViewFrame.size.height - self.frame.size.height/4)
        
        // Set starting and final size of swipeMinimizeView
        startingSize = self.frame.size
        finalSize = CGSize(width: parentViewFrame.size.width/2 - 10,
                           height: (parentViewFrame.size.width/2) * aspectRatio)
        
        // Set common range totals once
        rangeTotal = finalCenter!.y - startingCenter!.y
        widthRange = startingSize!.width - finalSize!.width
        centerXRange = finalCenter!.x - startingCenter!.x
    }
    
    // Handles the panning for swipeMinimizeView
    func handlePanning(_ panGesture: UIPanGestureRecognizer) {
        // Get translation point and the state of our pan gesture
        let translatedPoint = panGesture.translation(in: self.superview!)
        var gestureState = panGesture.state
        
        // Keep track of y-position of our pan gesture
        // If change less than start, or greater than final center of swipeMinimizeView, end the state
        let yChange = panGesture.view!.center.y + translatedPoint.y
        
        if yChange < startingCenter?.y {
            gestureState = UIGestureRecognizerState.ended
        } else if yChange >= finalCenter?.y {
            gestureState = UIGestureRecognizerState.ended
        }
        
        // Scale if gesture began or changed
        if gestureState == UIGestureRecognizerState.began || gestureState == UIGestureRecognizerState.changed  {
            
            // Modify size as view is panned down
            let progress = ((panGesture.view!.center.y - startingCenter!.y) / rangeTotal)
            
            let invertedProgress = 1 - progress
            let newWidth = finalSize!.width + (widthRange * invertedProgress)
            
            panGesture.view?.frame.size = CGSize(width: newWidth, height: newWidth * aspectRatio)
            
            // Makes sure center x value moves along with size change
            let finalX = startingCenter!.x + (centerXRange * progress)
            
            panGesture.view?.center = CGPoint(x: finalX, y: panGesture.view!.center.y + translatedPoint.y)
            panGesture.setTranslation(CGPoint(x: 0, y: 0), in: self.superview)
            
        } else if gestureState == UIGestureRecognizerState.ended {
            
            let topDistance = yChange - startingCenter!.y
            let bottomDistance = finalCenter!.y - yChange
            
            var chosenCenter: CGPoint = CGPoint.zero
            var chosenSize: CGSize = CGSize.zero
            self.isUserInteractionEnabled = false
            
            if topDistance > bottomDistance {
                // Animate to bottom
                chosenCenter = finalCenter!
                chosenSize = finalSize!
                
            } else {
                // Animate to top
                chosenCenter = startingCenter!
                chosenSize = startingSize!
            }
            
            // Default to a size and center if center is not starting or final
            if panGesture.view?.center != chosenCenter {
                UIView.animate(withDuration: 0.4, animations: {
                    panGesture.view?.frame.size = chosenSize
                    panGesture.view?.center = chosenCenter
                    
                }, completion: {(done: Bool) in
                    self.isUserInteractionEnabled = true
                })
            } else {
                self.isUserInteractionEnabled = true
            }
        }
    }
    
    // Delegate method to recognize two gestures at the same time, defaulting to NO
    // TODO: may need to set to YES/true later
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}










