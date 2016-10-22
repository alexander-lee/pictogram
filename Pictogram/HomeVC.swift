//
//  HomeVC.swift
//  Pictogram
//
//  Created by Alexander on 10/18/16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Parse
import SVPullToRefresh

class HomeVC: UITableViewController {
    var posts: [Post] = [];
    var pageCount: Int = 1;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.addInfiniteScrollingWithActionHandler { () -> Void in
            Post.getUserImages(++self.pageCount, successCallback: { (posts) -> Void in
                self.posts = posts;
                self.tableView.reloadData();
                }, error: nil);
        }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: Selector("refreshData:"), forControlEvents: UIControlEvents.ValueChanged)
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if(PFUser.currentUser() == nil){
            performSegueWithIdentifier("Login", sender: self);
        }
        self.refreshData(self.refreshControl);
    }

    // MARK: - TableView DataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostTableViewCell;
        let post = self.posts[indexPath.row];
        cell.post = post;

        return cell;
    }
    
    func refreshData(refreshControl: UIRefreshControl?){
        refreshControl?.beginRefreshing();
        pageCount = 1;
        
        Post.getUserImages(pageCount, successCallback: { (posts: [Post]) -> Void in
            self.posts = posts;
            self.tableView.reloadData();
            refreshControl?.endRefreshing();
            }, error: nil);
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
