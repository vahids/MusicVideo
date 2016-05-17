//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/16/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.perefedFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
        self.reachabilityStatusChanged()
        
        loadAPI()
    }
    
    func loadAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: self.didLoadData)
    }
    
    func didLoadData(videos: [Videos]){
        //        for item in videos {
        //            print("name = \(item.videoArtist)")
        //        }
        
        self.videos = videos
        tableView.reloadData()
        
        print(reachabilityStatus)
        
      /*  for (index, item) in videos.enumerate() {
            print("\(index). Name: \(item.videoName)")
        }*/
        
    }
    
    func perefedFontChange(){
        
        print("We Preferred Font has Changed")
    }
    
    func displayNoConnectionAlert(){
        let noConnectionAlert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (UIAlertAction) in
            print("OK choosen")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (UIAlertAction) in
            print("Cancel Action Choosed")
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            print("Delete Item Choosed")
        }
        
        noConnectionAlert.addAction(okAction)
        noConnectionAlert.addAction(cancelAction)
        noConnectionAlert.addAction(deleteAction)
        
        self.presentViewController(noConnectionAlert, animated: true) { 
            print("Alert Displayed")
        }
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            self.displayNoConnectionAlert()
            
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
           // displayLable.text = "WiFi Connection Reachable"
            if videos.count <= 0 {
                self.loadAPI()
            } 
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
            if videos.count <= 0 {
                self.loadAPI()
            }
        default:
            return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideTVCell

        cell.video = videos[indexPath.row]

        return cell
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
