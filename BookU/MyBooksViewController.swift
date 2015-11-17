//
//  MyBooksViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Charles Konkol on 2015-11-16.
//  Copyright © 2015 Parse. All rights reserved.
//
import Parse
import UIKit

class MyBooksViewController: UIViewController {
    
    
    var currentObject : PFObject?
    var blnLoad:Bool!

    @IBOutlet weak var txttitle: UITextField!
   
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var txtauhthor: UITextField!
    
    @IBOutlet weak var txtpublisher: UITextField!
    
    
    @IBOutlet weak var txtisbn: UITextField!
    
    
    @IBOutlet weak var txtprice: UITextField!
    
    
    @IBOutlet weak var txtcondition: UITextField!
    
    
    @IBOutlet weak var sold: UISwitch!
    
    @IBOutlet weak var message: UITextView!
    
    @IBAction func sold(sender: UISwitch) {
    }
    
    @IBAction func btnSave(sender: UIButton) {
         if blnLoad == true {
             let Book = currentObject!
            Book["username"] = MyUserName
            Book["title"] = txttitle.text
            Book["author"] = txtauhthor.text
            Book["pub"] = txtpublisher.text
            Book["isbn"] = txtisbn.text
            Book["cond"] = txtcondition.text
            Book["price"] = txtprice.text
            Book["sold"] = sold.on
            Book["msg"] = ""
            Book.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                 self.dismissViewControllerAnimated(false, completion: nil)
            } else {
                // There was a problem, check error.description
            }
        }
            
        }
        else
         {
            
            let Book = PFObject(className:"MyBooks")
            Book["username"] = MyUserName
            Book["title"] = txttitle.text
            Book["author"] = txtauhthor.text
            Book["pub"] = txtpublisher.text
            Book["isbn"] = txtisbn.text
            Book["cond"] = txtcondition.text
             Book["price"] = txtprice.text
            Book["sold"] = sold.on
             Book["msg"] = ""
            Book.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
             self.dismissViewControllerAnimated(false, completion: nil)
//            let query = PFQuery(className:"MyBooks")
//            query.whereKey("username", equalTo: MyUserName)
//            query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) -> Void in
//                if error == nil {
//                    if object!.count > 0 {
//                        if let object = object! as? [PFObject] {
//                            for object in object {
//                                object["vote"] = true
//                                object.saveInBackground()
//                            }
//                        }
//                    }
//                    
//                }
//
//                    }
        }
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let object = currentObject {
            blnLoad = true
            txttitle.text = (object["title"] as! String)
            txtauhthor.text = (object["author"] as! String)
            txtpublisher.text = (object["pub"] as! String)
            txtisbn.text=(object["isbn"] as! String)
            txtcondition.text = (object["cond"] as! String)
            txtprice.text = (object["price"] as! String)
            sold.on=(object["sold"] as! Bool)
            
            message.text = (object["msg"] as! String)
              self.btnsave.setTitle("Update", forState: UIControlState.Normal)

        }
        else
        {
             blnLoad = false
        }
//txttitle.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(sender: UIBarButtonItem) {
         self.dismissViewControllerAnimated(false, completion: nil)
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
