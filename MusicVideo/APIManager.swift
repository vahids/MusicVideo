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
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()){
                    completion(result: error!.localizedDescription)
                }
            } else { // Got data from api successfully!
                
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? JSONDictionaty {
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            dispatch_async(dispatch_get_main_queue()){
                                completion(result: "Convert data to JSON successfuly")
                            }
                        }
                    }
                    
                } catch {
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "Error in converting data to JSON")
                    }
                }
            }
        }
        task.resume()
    }
}