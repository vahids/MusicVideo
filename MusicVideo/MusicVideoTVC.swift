//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/16/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController, UISearchResultsUpdating {

    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    
    let resultSarchController = UISearchController(searchResultsController: nil)
    
    var limit: String = "10"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.perefedFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        resultSarchController.searchResultsUpdater = self
        
        self.reachabilityStatusChanged()
        
        loadAPI()
    }
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        
        if resultSarchController.active {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
        } else {
            loadAPI()
        }
    }
    
    
    func getAPICount() {
        
        if  let count = NSUserDefaults.standardUserDefaults().objectForKey("SliderValue") {
            self.limit = "\(count)"
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        print("Refresh Date: \(refreshDate)")
        
        refreshControl?.attributedTitle = NSAttributedString(string: refreshDate)
    }
    
    func loadAPI(){
        
        getAPICount()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: self.didLoadData)
    }
    
    func didLoadData(videos: [Videos]){
        //        for item in videos {
        //            print("name = \(item.videoArtist)")
        //        }
        
        self.videos = videos
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = "The iTunes Top \(limit) Music Videos"
        
        definesPresentationContext = true
        resultSarchController.dimsBackgroundDuringPresentation = false
        resultSarchController.searchBar.placeholder = "Search for Artist"
        resultSarchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        tableView.tableHeaderView = resultSarchController.searchBar
        
        
        
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
            //view.backgroundColor = UIColor.redColor()
            self.displayNoConnectionAlert()
            
        case WIFI:
            //view.backgroundColor = UIColor.greenColor()
           // displayLable.text = "WiFi Connection Reachable"
            if videos.count <= 0 {
                self.loadAPI()
            } 
        case WWAN:
           // view.backgroundColor = UIColor.yellowColor()
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
        if resultSarchController.active {
            print("Number of rows in section: \(filterSearch.count)")
            return filterSearch.count
        }
        print("NO")
        
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let seugeResuseIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideTVCell

        if resultSarchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
            cell.video = videos[indexPath.row]
        }

        return cell
    }
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.seugeResuseIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                
                var video: Videos
                
                if resultSarchController.active {
                    video = filterSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                
                dvc.video = video
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
       
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
    func filterSearch(searchText: String){
        filterSearch = videos.filter {
            videos in
                return videos.videoArtist.lowercaseString.containsString(searchText.lowercaseString) || videos.videoName.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    


}
