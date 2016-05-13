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

    func didLoadData(result: String){
       
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        
        alert.addAction(ok)
        self.presentViewController(alert, animated: true) {
        }
    }
}

