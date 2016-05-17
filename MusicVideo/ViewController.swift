//
//  ViewController.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/13/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        self.reachabilityStatusChanged()
        
        initApi()
    }
    
    func initApi(){
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
        
       /* for (index, item) in videos.enumerate() {
            print("\(index). Name: \(item.videoName)")
        }*/
        
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            displayLable.text = "No Internet Connection"
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
            displayLable.text = "WiFi Connection Reachable"
            self.initApi()
        case WWAN:
            view.backgroundColor = UIColor.yellowColor()
            displayLable.text = "Cellular Connection (2G/3G/4G) Reachable"
        default:
            return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = video.videoName
        cell.detailTextLabel?.text = video.videoArtist
        
        return cell
        
    }
}

