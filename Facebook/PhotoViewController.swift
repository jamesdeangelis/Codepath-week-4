//
//  PhotoViewController.swift
//  Facebook
//
//  Created by James  on 2/26/15.
//  Copyright (c) 2015 James . All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var zoomedInPhotoContainer: UIImageView!
    @IBOutlet weak var doneButton: UIImageView!
    @IBOutlet weak var actionsBar: UIImageView!
    
    var fullSizeImage: UIImage!
    var scrollMove: CGFloat!
    var scrollAlpha: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photoScrollView.contentSize = CGSize(width: 320, height: 768)
        
        zoomedInPhotoContainer.image = fullSizeImage
        
        // Allow us to track scrolling
        photoScrollView.delegate = self
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        //hide the actions when scrolling begins
        doneButton.hidden = true
        actionsBar.hidden = true
        
        //capture the amount of scroll movement on the y-axis
        scrollMove = photoScrollView.contentOffset.y
        
        println("scroll move: \(scrollMove)")
        
        //If the scroll movement is positive (downwards) update the alpha of the scroll view
        if (scrollMove > 0) {
            scrollAlpha = photoScrollView.contentOffset.y / 100
            photoScrollView.backgroundColor = UIColor(white: 0, alpha: 1 - scrollAlpha)
            
        //If the scroll movement is negative (upwards) update the alpha of the scroll view
        } else if (scrollMove < 0) {
            scrollAlpha = -photoScrollView.contentOffset.y / 100
            photoScrollView.backgroundColor = UIColor(white: 0, alpha: 1 - scrollAlpha)
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
        
        // Show the actions again
        doneButton.hidden = false
        actionsBar.hidden = false
        
        // If we scroll more than the 100 points, perform the dismiss action
        if (photoScrollView.contentOffset.y > 100 || photoScrollView.contentOffset.y < -100) {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDismiss(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
