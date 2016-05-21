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
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    var video: Videos?
    var securitySwitch: Bool = false
    
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
    
    // MARK: Share button Pressed
    @IBAction func sharePress(sender: UIBarButtonItem) {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecuritySetting")
        
        switch securitySwitch {
        case true:
            touchIdCheck()
        default:
            shareMedia()
        }
        shareMedia()
    }
    
    
    // MARK: Touch ID Check
    func touchIdCheck(){
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        let context = LAContext()
        var touchIdError : NSError?
        let reasonString = "Touch-ID authentications is need to share info on Social Media"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIdError){
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) in
                if success {
                    dispatch_async(dispatch_get_main_queue(), { 
                        [unowned self] in
                            self.shareMedia()
                    })
                } else {
                    alert.title = "Unsuccessful!"
                    switch LAError(rawValue: policyError!.code)! {
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by application"
                    
                    case .AuthenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on the device"
                    
                    case .SystemCancel:
                        alert.message = "Authentication was cancelled by the system"
                        
                    case .TouchIDLockout:
                        alert.message = "Too many failed attempts"
                    
                    case .UserCancel:
                        alert.message = "You Cancelled the request"
                    
                    case .UserFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                        
                    default:
                        alert.message = "Unable to Authenticate!"
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        [unowned self] in
                            self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                }
            })
        } else {
            
            alert.title = "Error"
            
            switch LAError(rawValue: touchIdError!.code)! {
                
            case .TouchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
                
            case .TouchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
            
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .InvalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
            }
            
            dispatch_async(dispatch_get_main_queue()){
                [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
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
