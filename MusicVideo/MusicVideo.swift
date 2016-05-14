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
    private var _videoRights: String
    private var _videoPrice: String
    private var _videoArtist: String
    private var _videoTitle: String
    private var _videoGenre: String
    private var _videoReleaseDate: String
    
    var videoImageData: NSData?
    
    var videoName: String{
        return _videoName
    }
    
    var videoImageUrl: String{
        return _videoImageUrl
    }
    
    var videoUrl: String{
        return _videoUrl
    }
    
    var videoRights: String{
        return _videoRights
    }
    
    var videoArtist: String{
        return _videoArtist
    }
    
    var videoTitle: String{
        return _videoTitle
    }
    
    var videoGenre: String{
        return _videoGenre
    }
    
    var releaseDate: String{
        return _videoReleaseDate
    }
    
    // MARK: Initilazer
    init(data: JSONDictionaty){
        
        //// Video Name
        if let name = data["im:name"] as? JSONDictionaty,
            videoName = name["label"] as? String {
            self._videoName = videoName
        } else {
            self._videoName = ""
        }
        
        // Video Image URL
        if let img = data["img:image"] as? JSONArray,
            image = img[2] as? JSONDictionaty,
            finalImage = image["label"] as? String {
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
        
        // Rights
        if let rights = data["rights"] as? JSONDictionaty,
            finalRights = rights["label"] as? String {
                self._videoRights = finalRights
            
        } else {
            self._videoRights = ""
        }
        
        
        // Artist
        if let artist = data["im:artist"] as? JSONDictionaty,
            finalArtist = artist["label"] as? String {
            self._videoArtist = finalArtist
        } else {
            self._videoArtist = ""
        }
        
        // Title
        if let title = data["title"] as? JSONDictionaty,
            finalTitle = title["label"] as? String{
                self._videoTitle = finalTitle
        } else {
            self._videoTitle = ""
        }
        
        
        // Category
        if let category = data["category"] as? JSONDictionaty,
            attrib = category["attributes"] as? JSONDictionaty,
            term = attrib["term"] as? String {
            self._videoGenre = term
        } else {
            self._videoGenre = ""
        }
        
        
        // Release Date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionaty,
            attrib = releaseDate["attributes"] as? JSONDictionaty,
            label = attrib["label"] as? String{
            self._videoReleaseDate = label
        } else {
            self._videoReleaseDate = ""
        }
        
        // Price
        if let price = data["im:price"] as? JSONDictionaty,
            label = price["label"] as? String {
            self._videoPrice = label
        } else {
            self._videoPrice = ""
        }
        
        
    }
    
}