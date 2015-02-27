//
//  PhotoViewController.swift
//  Facebook
//
//  Created by James  on 2/26/15.
//  Copyright (c) 2015 James . All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var zoomedInPhotoContainer: UIImageView!
    
    var fullSizeImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoScrollView.contentSize = zoomedInPhotoContainer.frame.size
        photoScrollView.frame.size = view.bounds.size
        
        zoomedInPhotoContainer.image = fullSizeImage
        
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
