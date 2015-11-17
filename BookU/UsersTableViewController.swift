//
//  UsersTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Charles Konkol on 2015-11-16.
//  Copyright © 2015 Parse. All rights reserved.
//
import Foundation
import Parse
import ParseUI
import UIKit
import Parse

class UsersTableViewController: PFQueryTableViewController {

    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "MyBooks"
        
        self.textKey = "username"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "MyBooks")
        query.whereKey("username", equalTo: MyUserName)
        query.orderByAscending("username")
        
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
        
        
        return query
    }
    
    @IBAction func btnback(sender: UIBarButtonItem) {
         self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
         let cellIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        if cell == nil {
            cell = PFTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = object?["title"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("MyBooks", sender: tableView)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        let detailScene = segue.destinationViewController as! MyBooksViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let row = Int(indexPath.row)
            detailScene.currentObject = objects![row] as? PFObject
        }
}
}
