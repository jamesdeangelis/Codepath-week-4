//
//  ViewController.swift
//  Facebook
//
//  Created by James  on 2/26/15.
//  Copyright (c) 2015 James . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var homefeedView: UIImageView!
    @IBOutlet weak var wedding1: UIImageView!
    
    var isPresenting: Bool = true
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    
    var blackView: UIView!
    var selectedImageView: UIImageView!
    var aspectFill: UIImageView!
    var movingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        feedScrollView.contentSize = homefeedView.frame.size
        feedScrollView.frame.size = view.bounds.size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
        var destinationViewController = segue.destinationViewController as PhotoViewController
        
        destinationViewController.fullSizeImage = selectedImageView.image
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
//    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        interactiveTransition = UIPercentDrivenInteractiveTransition()
//        
//        //Setting the completion speed gets rid of a weird bounce effect bug when transitions complete
//        interactiveTransition.completionSpeed = 0.99
//        return interactiveTransition
//    }

    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var frame = containerView.convertRect(selectedImageView.frame, fromView: feedScrollView)
        
        if (isPresenting) {
            
            var photoViewContoller = toViewController as PhotoViewController
            var finalImageView = photoViewContoller.zoomedInPhotoContainer
            var window = UIApplication.sharedApplication().keyWindow!
            
            //Hide the real deal while we're transitioning movingImageView
            
            selectedImageView.hidden = true
            photoViewContoller.zoomedInPhotoContainer.hidden = true
            
            //Set movingImageView to copy all of the properties of the selectedImageView
            
            movingImageView = UIImageView(image: selectedImageView.image)
            movingImageView.frame = frame
            
            movingImageView.contentMode = selectedImageView.contentMode
            movingImageView.clipsToBounds = selectedImageView.clipsToBounds
            
            // Create our blackout view
//            blackView = UIView(frame: fromViewController.view.frame)
//            blackView.backgroundColor = UIColor.blackColor()
//            blackView.alpha = 0
            
            //Add the blackout to the photoViewController
//            containerView.addSubview(blackView)
            
            containerView.addSubview(toViewController.view)
            
            //Finally add our new copy to the photoViewController
            window.addSubview(movingImageView)
            
            photoViewContoller.view.alpha = 0
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                photoViewContoller.view.alpha = 1
                self.movingImageView.frame = finalImageView.frame
//                self.blackView.alpha = 1
                
                }) { (finished: Bool) -> Void in
                    
                    transitionContext.completeTransition(true)
                    self.movingImageView.hidden = true
                    photoViewContoller.zoomedInPhotoContainer.hidden = false
            }
            
        // Define the dismiss transition
        } else {
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.movingImageView.hidden = false
                fromViewController.view.alpha = 0
                
//                self.blackView.alpha = 0
                self.movingImageView.frame = frame
                
                }) { (finished: Bool) -> Void in
                    
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()   
                    self.movingImageView.removeFromSuperview()
//                    self.blackView.removeFromSuperview()
                    self.selectedImageView.hidden = false
            }
        }
    }
    
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        var imageView = sender.view as UIImageView
        selectedImageView = imageView
        performSegueWithIdentifier("photoSegue", sender: self)
        
        }
    
    
}

