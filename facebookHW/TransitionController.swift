//
//  TransitionController.swift
//  facebookHW
//
//  Created by Andrew Chin on 9/2/14.
//  Copyright (c) 2014 Andrew Chin. All rights reserved.
//

import UIKit

class TransitionController: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    var tapTargetImageView: UIImageView!
//    var toController: PhotoViewController!
//    var fromController: ViewController!

    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        // TODO: animate the transition
        
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        var window = UIApplication.sharedApplication().keyWindow
        var imageFrame = window.convertRect(tapTargetImageView.frame, fromView: tapTargetImageView.superview)
        
        
        if (isPresenting == true) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            var transitionImageView = UIImageView(image: tapTargetImageView.image)
            transitionImageView.frame = imageFrame
            transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
            transitionImageView.clipsToBounds = true
            window.addSubview(transitionImageView)
            
            var destinationImageView = (toViewController as PhotoViewController).imageView
            var toFrame: CGRect!
            
            
            //calculate where destination image coordinate is going to be
            if (destinationImageView.image.size.width > destinationImageView.image.size.height) {
                toFrame = CGRect(x: 0, y: 150, width: 320, height: 214)
                println("The picture is horizontal")
            } else
            {
                toFrame = CGRect(x: 0, y: 50, width: 320, height: 480)
                println("The picture is vertical")
            }
            
            //sets where the destination image frame should be
            destinationImageView.frame = toFrame
            destinationImageView.hidden = true

            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                transitionImageView.frame = toFrame
             
                
                }) { (finished: Bool) -> Void in
                    destinationImageView.hidden = false
                    transitionImageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            
            //get source scroll View Offset
            var sourceScrollViewOffsetY = (fromViewController as PhotoViewController).scrollView.contentOffset.y
            println("scroll View Offset Y \(sourceScrollViewOffsetY)")
            //copy the transition image
            var sourceImageView = (fromViewController as PhotoViewController).imageView
            var transitionImageView = UIImageView(image: sourceImageView.image)
//            transitionImageView.frame = sourceImageView.frame
            transitionImageView.frame = CGRect(x: sourceImageView.frame.origin.x, y: sourceImageView.frame.origin.y - sourceScrollViewOffsetY, width: sourceImageView.frame.width, height: sourceImageView.frame.height)
            transitionImageView.contentMode = UIViewContentMode.ScaleAspectFill
            transitionImageView.clipsToBounds = true
            window.addSubview(transitionImageView)

            //hide the original image
            sourceImageView.hidden = true
            fromViewController.view.alpha = (fromViewController as PhotoViewController).scrollAlpha
        
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                transitionImageView.frame = imageFrame   //go back to its originating frame
                fromViewController.view.alpha = 0
                }, completion: { (Bool) -> Void in
                    transitionImageView.removeFromSuperview()
                    fromViewController.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
        
        
    }

}
