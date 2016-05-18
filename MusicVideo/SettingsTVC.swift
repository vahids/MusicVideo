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
    @IBOutlet weak var numberOfMusicVideo: UILabel!
    @IBOutlet weak var APICount: UILabel!
    @IBOutlet weak var dragSliderText: UILabel!
    @IBOutlet weak var sliderCount: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.perefedFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)

        tableView.alwaysBounceVertical = false
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecuritySetting")
        
        title = "Settings"
        
        sliderCount.minimumValue = 10
        sliderCount.maximumValue = 200
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let value = defaults.objectForKey("SliderValue") {
            sliderCount.value =  value as! Float
            APICount.text = "\(value)"
        } else {
            sliderCount.value = 10.0
            APICount.text = "10"
        }
        
        
        }
    
    
    @IBAction func touchIDClick(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on, forKey: "SecuritySetting")
        } else {
            defaults.setBool(false, forKey: "SecuritySetting")
        }
        
    }
    
    func perefedFontChange(){
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragSliderText.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfMusicVideo.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
        print("We Preferred Font has Changed")
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    @IBAction func sliderChange(sender: UISlider) {
       // APICount.text = "\(sliderCount.value as Int)" 
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCount.value), forKey: "SliderValue")
        APICount.text = "\(Int(sliderCount.value))"
    }
}
