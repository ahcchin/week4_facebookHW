//
//  ViewController.swift
//  facebookHW
//
//  Created by Andrew Chin on 8/27/14.
//  Copyright (c) 2014 Andrew Chin. All rights reserved.
//

import UIKit

//class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
class ViewController: UIViewController {
    
    @IBOutlet var feedScrollView: UIScrollView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tabBarImageView: UIImageView!
    @IBOutlet var actionBarImageView: UIImageView!
    @IBOutlet var searchBarImageView: UIImageView!
    @IBOutlet var feedImageView: UIImageView!
    
    
    
    var tapTargetImageView: UIImageView!
    var isPresenting: Bool = true
    var transition: TransitionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        feedScrollView.contentSize = feedImageView.frame.size
        feedScrollView.contentInset.bottom = tabBarImageView.frame.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        var sourceViewController = segue.sourceViewController as ViewController
        
        destinationViewController.image = tapTargetImageView.image
        
        transition = TransitionController()
        transition.tapTargetImageView = tapTargetImageView
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = transition
        
        println("Called prepareForSegue")
//        destinationViewController.transitioningDelegate = self
        
    }
    
    
    
    @IBAction func onPhotoTap(tapGesture: UITapGestureRecognizer) {
        tapTargetImageView = tapGesture.view as UIImageView
        performSegueWithIdentifier("PhotoSegue", sender: self)
    }

}

