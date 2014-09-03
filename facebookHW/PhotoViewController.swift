//
//  PhotoViewController.swift
//  facebookHW
//
//  Created by Andrew Chin on 9/2/14.
//  Copyright (c) 2014 Andrew Chin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {


    var image: UIImage!
    var scrollToDismiss: Bool! = false
    var scrollAlpha: CGFloat! = 1.0

    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var doneImageView: UIImageView!
    @IBOutlet var photoActionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
//        scrollView.contentSize = CGSize(width: 320, height: 1000)
        scrollView.contentSize = self.view.frame.size
        scrollView.delegate = self
        scrollView.bounces = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        var offset = abs(Float(scrollView.contentOffset.y))
        
        
        if (offset <= 100) {
            scrollAlpha = 1 - (CGFloat(offset)/100)
        } else if (offset > 100){
            scrollToDismiss = true
            scrollAlpha = 0
        }
//
//        println("Scroll content y: \(offset)")
//        println("Scroll alpha y: \(scrollAlpha)")
        
//        doneImageView.alpha =
        
        
        self.view.backgroundColor = UIColor(white: 0, alpha: scrollAlpha)
        doneImageView.alpha = scrollAlpha * 2
        photoActionImageView.alpha = scrollAlpha * 2

        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {

    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
            
            if (scrollToDismiss == true) {
                dismissViewControllerAnimated(true, completion: nil)
            }
                
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
