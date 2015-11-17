//
//  HomeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Charles Konkol on 2015-11-16.
//  Copyright © 2015 Parse. All rights reserved.
//
import Parse
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()
        if currentUser == nil
        {
            let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(nil, forKey: "username")
             defaults.synchronize()

        
        }
        else
        {
               let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.objectForKey("username") as? String {
           MyUserName = (defaults.objectForKey("username") as? String)!
            PFUser.objectWithoutDataWithObjectId(MyUserName)
            print(MyUserName)

        }
               }

        // Do any additional setup after loading the view.
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
