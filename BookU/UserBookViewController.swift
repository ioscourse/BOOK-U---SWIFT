//
//  UserBookViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Charles Konkol on 2015-11-16.
//  Copyright © 2015 Parse. All rights reserved.
//
import Parse
import UIKit

class UserBookViewController: UIViewController {
   var currentObject : PFObject?
    var msg:String!
    
    @IBOutlet weak var txtusername: UITextField!
    
    @IBOutlet weak var txttitle: UITextField!
    
    @IBOutlet weak var txtauthor: UITextField!
   
    @IBOutlet weak var txtpublisher: UITextField!
    
    @IBOutlet weak var txtisbn: UITextField!
    
    @IBOutlet weak var txtprice: UITextField!
    
    @IBOutlet weak var txtcondition: UITextField!
    
    @IBOutlet weak var sold: UISwitch!
    
    @IBOutlet weak var txtmessage: UITextView!
    
    @IBAction func btnMessage(sender: UIButton) {
                    let query = PFQuery(className:"MyBooks")
                    query.whereKey("title", equalTo: txttitle.text!)
                    query.whereKey("username", equalTo: TheirUserName)
                    query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            if object!.count > 0 {
                                if let object = object! as? [PFObject] {
                                    for object in object {
                                        if (self.msg == "")
                                        {
                                            object["msg"] = "\(MyUserName): \(self.txtmessage.text)\n"
                                            object.saveInBackground()
                                        }
                                        else
                                        {
                                            object["msg"] = "\(self.msg)\n\(MyUserName): \(self.txtmessage.text)\n"
                                            object.saveInBackground()
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
        
                            }
        
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBAction func btnback(sender: UIBarButtonItem) {
         self.dismissViewControllerAnimated(false, completion: nil)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.msg = ""
        if let object = currentObject {
             txtusername.text = (object["username"] as! String)
            txttitle.text = (object["title"] as! String)
            txtauthor.text = (object["author"] as! String)
            txtpublisher.text = (object["pub"] as! String)

            txtisbn.text = (object["isbn"] as! String)
            txtprice.text=(object["price"] as! String)
            txtcondition.text = (object["cond"] as! String)
            sold.on=(object["sold"] as! Bool)
            

            self.msg = (object["msg"] as! String)
            txtmessage.becomeFirstResponder()
           
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
