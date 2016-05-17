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
        musicImage.image = UIImage(named: "ImageNotAvailable")
    }

}
