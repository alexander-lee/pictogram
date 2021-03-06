//
//  LoginViewController.swift
//  Pictogram
//
//  Created by Alexander on 10/13/16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        let username = usernameTextField.text ?? "";
        let password = passwordTextField.text ?? "";
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription);
            } else {
                print("User Logged In Successfully");
                self.dismissViewControllerAnimated(true, completion: nil);
            }
        }
    }

    @IBAction func signupPressed(sender: AnyObject) {
        let newUser = PFUser();
        
        newUser.username = usernameTextField.text ?? "";
        newUser.email = usernameTextField.text ?? "";
        newUser.password = passwordTextField.text ?? "";
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription);
            } else {
                print("User Registered Successfully");
                self.dismissViewControllerAnimated(true, completion: nil);
            }
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
