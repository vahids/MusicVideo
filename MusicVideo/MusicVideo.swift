//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/13/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import Foundation

class Videos{
    
    private var _videoName: String
    private var _videoImageUrl: String
    private var _videoUrl: String
    
    var videoName: String{
        return _videoName
    }
    
    var videoImageUrl: String{
        return _videoImageUrl
    }
    
    var videoUrl: String{
        return _videoUrl
    }
    
    init(data: JSONDictionaty){
        
        //// Video Name
        if let name = data["im:name"] as? JSONDictionaty, videoName = name["lable"] as? String {
            self._videoName = videoName
        } else {
            self._videoName = ""
        }
        
        // Video Image URL
        if let img = data["img:image"] as? JSONArray,
            image = img[2] as? JSONDictionaty,
            finalImage = image["lable"] as? String {
                self._videoImageUrl = finalImage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            self._videoImageUrl = ""
        }
        
        // Video URL
        if let url = data["link"] as? NSArray,
            urlAttrib = url[1] as? JSONDictionaty,
            finalAttrib = urlAttrib["attributes"] as? JSONDictionaty,
            finalurl = finalAttrib["href"] as? String{
                self._videoUrl = finalurl
        } else {
            self._videoUrl = ""
        }
    }
    
}