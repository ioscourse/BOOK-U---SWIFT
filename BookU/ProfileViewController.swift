//
//  ProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Charles Konkol on 2015-11-16.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    

    @IBOutlet weak var txtusername: UITextField!
  
    @IBOutlet weak var txtpassword: UITextField!
    
    @IBOutlet weak var txtpassword2: UITextField!
    
    @IBOutlet weak var txtemail: UITextField!
    
    
    @IBOutlet weak var txtphone: UITextField!
   
    @IBOutlet weak var btnregister: UIButton!
    
    @IBAction func btnregister(sender: UIButton) {
         let currentUser = PFUser.currentUser()
         if currentUser == nil {
        let user = PFUser()
        user.username = txtusername.text
        user.password = txtpassword.text
        user.email = txtemail.text
        // other fields can be set just like with PFObject
        user["phone"] = txtphone.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setObject(self.txtusername.text, forKey: "username")
                
                
                defaults.synchronize()
                
                self.dismissViewControllerAnimated(false, completion: nil)


            }
        }
        }
        else
         {
            let currentUser:PFUser = PFUser.currentUser()!
            currentUser.setObject(txtusername.text!, forKey: "username")
             currentUser.setObject(txtpassword.text!, forKey: "password")
             currentUser.setObject(txtemail.text!, forKey: "email")
             currentUser.setObject(txtphone.text!, forKey: "phone")
            currentUser.saveInBackground()
             self.dismissViewControllerAnimated(false, completion: nil)
            
            
        }
    }
    
    @IBAction func btnBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(false, completion: nil)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            currentUser!.refreshInBackgroundWithBlock { (object, error) -> Void in
                print("Refreshed")
                currentUser!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
                    
                    self.txtusername.text = currentUser!.objectForKey("username") as? String
                       self.txtpassword.text = currentUser!.objectForKey("password") as? String
                       self.txtemail.text = currentUser!.objectForKey("email") as? String
                       self.txtphone.text = currentUser!.objectForKey("phone") as? String
                    
                    
                    self.btnregister.setTitle("Update", forState: UIControlState.Normal)
                    self.txtpassword.enabled = false
                    self.txtpassword2.enabled = false
                    self.txtusername.enabled = false

                }
            }
        } else {
             txtusername.becomeFirstResponder()
            // Show the signup or login screen
        }        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
