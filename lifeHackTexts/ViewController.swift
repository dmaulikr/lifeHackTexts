//
//  ViewController.swift
//  lifeHackTexts
//
//  Created by Felipe Samuel Rodriguez on 10/8/16.
//  Copyright © 2016 Technigraphic. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
        
            if granted{
                print("Notification access granted")
            }else{
                print(error?.localizedDescription)
            }
        
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton){
        scheduledNotification(inSeconds: 5, completion: { success in
            if success{
                print("Succesfully scheduled notification")
            }else{
                print("Error scheduling notifcation")
            }})
        }
    
    func scheduledNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
//    func scheduledNotification(inSeconds: TimeInterval, completion: (Success: Bool) -> ()) {
        
        let notif = UNMutableNotificationContent()
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "The new notification options in IOS 10 are what I've always dreamed of!"
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print(error)
                completion(false)
            }else{
                completion(true)
            }
        })
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

