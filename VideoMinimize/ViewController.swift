//
//  ViewController.swift
//  VideoMinimize
//
//  Created by Stanley Pan on 23/11/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var swipeMinimizeView: SwipeMinimizeView!
    var moviePlayerController: MPMoviePlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create path to mp4, set up properties
        let path = Bundle.main.path(forResource: "beach", ofType: "mp4")
        moviePlayerController = MPMoviePlayerViewController(contentURL: URL(fileURLWithPath: path!))
        moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyle.none
        moviePlayerController.moviePlayer.scalingMode = MPMovieScalingMode.aspectFit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        swipeMinimizeView.configureSizeAndPosition(self.view.frame)
        
        // Make MPMoviePlayerViewController same size as custom swipeMinimizeView, add it as subview
        moviePlayerController.view.frame = CGRect(x: 0, y: 0, width: swipeMinimizeView.frame.size.width, height: swipeMinimizeView.frame.size.height)
        swipeMinimizeView.addSubview(moviePlayerController.view)
        moviePlayerController.moviePlayer.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Reveal custom swipeMinimizeView, play video
    @IBAction func playMovie(_ sender: UIButton) {
        self.swipeMinimizeView.isHidden = false
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.swipeMinimizeView.alpha = 1.0
            }, completion: {(done: Bool) in
                self.moviePlayerController.moviePlayer.play()
            })
        }
    }
}
