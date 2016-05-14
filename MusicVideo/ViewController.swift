//
//  ViewController.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/13/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: self.didLoadData)
    }

    func didLoadData(videos: [Videos]){
//        for item in videos {
//            print("name = \(item.videoArtist)")
//        }
        
        print(reachabilityStatus)
        
        for (index, item) in videos.enumerate() {
            print("\(index). Name: \(item.videoName)")
        }
        
    }
}

