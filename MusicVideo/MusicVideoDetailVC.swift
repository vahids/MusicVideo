//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/17/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {

    var video: Videos?
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoPrice: UILabel!
    @IBOutlet weak var videoGenre: UILabel!
    @IBOutlet weak var videoRights: UILabel!
    
    override func viewDidLoad() {
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
    
    //MARK: Actions

    @IBAction func playPress(sender: AnyObject) {
    }
    
    @IBAction func sharePress(sender: AnyObject) {
    }

}
