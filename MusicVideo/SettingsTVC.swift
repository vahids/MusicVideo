//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Vahid Sayad on 5/17/16.
//  Copyright © 2016 Vahid Sayad. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {

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
    
    @IBAction func sliderChange(sender: UISlider) {
       // APICount.text = "\(sliderCount.value as Int)" 
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCount.value), forKey: "SliderValue")
        APICount.text = "\(Int(sliderCount.value))"
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeVC = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeVC, animated: true, completion: nil)
            } else {
                mailAlert()
                // No email account Setup on phone
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController{
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["vahidgiga@gmail.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Vahid, \n\nI would like to share following feedback... \n", isHTML: false)
        
        return mailComposeVC
    }
    
    func mailAlert(){
        
        let alertController = UIAlertController(title: "Alert", message: "No Email account setup for Phone", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { action -> Void in
            //
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
