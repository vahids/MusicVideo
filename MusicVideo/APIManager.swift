//
//  APIManager.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/13/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import Foundation

class APIManager{
    
    func loadData(urlString: String, completion: (result: String) -> Void) {
        
        // Stop caching URL
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        //let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()){
                if error != nil {
                    completion(result: error!.localizedDescription)
                } else {
                    completion(result: "Successful Connection")
                    print(data)
                }
            }
            
        }.resume()
        
    }
}