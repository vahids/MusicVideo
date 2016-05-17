//
//  APIManager.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/13/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import Foundation

class APIManager{
    
    
    func loadData(urlString: String, completion: [Videos] -> Void) {
        
        // Stop caching URL
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            if error != nil {
                 print(error!.localizedDescription)
                
            } else { // Got data from api successfully!
                
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? JSONDictionaty,
                        feed = json["feed"] as? JSONDictionaty,
                        entries = feed["entry"] as? JSONArray  {
                        
                        var videos = [Videos]()
                        for (index, entry) in entries.enumerate() {
                            let entry = Videos(data: entry as! JSONDictionaty)
                            entry.videoRank = index + 1
                            videos.append(entry)
                        }
                        
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()){
                                completion(videos)
                            }
                        }
                    }
                    
                } catch {
                    print("Error in JSONSerialization") 
                }
            }
        }
        task.resume()
    }
}