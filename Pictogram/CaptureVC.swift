//
//  CaptureVC.swift
//  Pictogram
//
//  Created by Alexander on 10/18/16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit

class CaptureVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var hasImage: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Tap Gesture to ImageView
        let tap = UITapGestureRecognizer(target: self, action: Selector("imageTapped:"));
        tap.delegate = self;
        
        uploadImageView.userInteractionEnabled = true;
        uploadImageView.addGestureRecognizer(tap);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        uploadImageView.image = image;
        hasImage = true;
        
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func imageTapped(sender: AnyObject?){
        let imagePickerVC = UIImagePickerController();
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = true;
        imagePickerVC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        
        self.presentViewController(imagePickerVC, animated: true, completion: nil);
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        let caption = captionTextField.text ?? "";
        Post.postUserImage(uploadImageView.image, withCaption: caption) { (success: Bool, error: NSError?) -> Void in
            // Reset View
            self.captionTextField.text = "";
            self.uploadImageView.image = UIImage(named: "popcorn");
            self.hasImage = false;
            
            let alert = UIAlertController(title: "Success", message: "Your Post has been submitted!", preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
            
            alert.addAction(okAction);
            self.presentViewController(alert, animated: true, completion: nil);
        }
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
