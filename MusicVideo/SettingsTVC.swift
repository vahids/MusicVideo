//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/17/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageQualityDisplay: UILabel!
    @IBOutlet weak var bestImageQualitySwitch: UISwitch!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.perefedFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)

        tableView.alwaysBounceVertical = false
        
        }
    
    func perefedFontChange(){
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        print("We Preferred Font has Changed")
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
