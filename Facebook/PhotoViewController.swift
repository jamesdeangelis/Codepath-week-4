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
    
    var imageOriginalCenter: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photoScrollView.contentSize = CGSize(width: 320, height: 678)
        zoomedInPhotoContainer.image = fullSizeImage
        
        photoScrollView.delegate = self
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        scrollMove = photoScrollView.contentOffset.y
        photoScrollView.backgroundColor = UIColor(white: 0, alpha: ((100-abs(scrollMove))/100))
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        doneButton.hidden = true
        actionsBar.hidden = true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
        doneButton.hidden = false
        actionsBar.hidden = false
        
        // If we scroll more than the 100 points, perform the dismiss action
        if (scrollMove > 100 || scrollMove < -100) {
            dismissViewControllerAnimated(true, completion: nil)    
        } else {
            photoScrollView.contentOffset.y = 0
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        doneButton.hidden = false
        actionsBar.hidden = false
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
