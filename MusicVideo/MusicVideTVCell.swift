//
//  MusicVideTVCell.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/16/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class MusicVideTVCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicRank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    var video: Videos?{
        didSet{
            updateCell()
        }
    }
    
    func updateCell(){
        musicTitle.text = video?.videoName
        musicRank.text = "\(video!.videoRank)"
        
        if video?.videoImageData != nil {
            print("Getting data from array...")
            musicImage.image = UIImage(data: video!.videoImageData!)
        } else {
            downloadImage(video!, imageView: self.musicImage)
        }
        //musicImage.image = UIImage(named: "ImageNotAvailable")
    }
    
    func downloadImage(video: Videos, imageView: UIImageView){
        print("Downloading")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            let data = NSData(contentsOfURL: NSURL(string: video.videoImageUrl)!)
            
            var image: UIImage?
            if data != nil {
                video.videoImageData = data
                image = UIImage(data: data!)
            } else {
                print("No DATA")
            }
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
        
    }

}
