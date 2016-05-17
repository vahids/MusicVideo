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
    
    func perefedFontChange(){
        videoName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        videoRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
        print("We Preferred Font has Changed")
    }
    
    
    //MARK: Actions

    @IBAction func playPress(sender: AnyObject) {
    }
    
    @IBAction func sharePress(sender: AnyObject) {
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
