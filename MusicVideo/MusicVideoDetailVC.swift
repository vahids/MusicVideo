//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/17/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicVideoDetailVC: UIViewController {

    var video: Videos?
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoPrice: UILabel!
    @IBOutlet weak var videoGenre: UILabel!
    @IBOutlet weak var videoRights: UILabel!
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.perefedFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        super.viewDidLoad()
        print("YES")
        videoName.text = video?.videoName
        videoPrice.text = video?.videoPrice
        videoGenre.text = video?.videoGenre
        videoRights.text = video?.videoRights
        self.navigationItem.title = video?.videoArtist
        title = video?.videoArtist
        
        if video?.videoImageData != nil {
            videoImage.image = UIImage(data: (video?.videoImageData)!)
            
        } else {
            videoImage.image = UIImage(named: "ImageNotAvailable")
        }
        
    }
    
    //MARK: preferredFontChange Function
    func perefedFontChange(){
        videoName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
        print("We Preferred Font has Changed")
    }
    
    
    //MARK: Actions

    @IBAction func playPress(sender: UIBarButtonItem) {
        
        let url = NSURL(string: video!.videoUrl)
        let player = AVPlayer(URL: url!)
        let playerVC = AVPlayerViewController()
        
        playerVC.player = player
        
        self.presentViewController(playerVC, animated: true) { 
            playerVC.player?.play()
        }
        
    }
    
    @IBAction func sharePress(sender: UIBarButtonItem) {
        
        shareMedia()
    }
    
    func shareMedia(){
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = "\(video?.videoName) by \(video?.videoArtist)"
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = video!.videoiTunesLink
        let activity5 = "(Shared with the Music Video app!"
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if activity == UIActivityTypeMail {
                print("Email Selected")
            }
        }
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
