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
    
    //Switch for turning on texts
    @IBOutlet weak var hackSwitch: UISwitch!
    
    //Array cointaing daily quotes
    var hacksArray: [String] = ["helo","dsds"]
    
    //Hack main label
    @IBOutlet weak var hackLbl: UILabel!
    
    //Button for setting the time
    @IBOutlet weak var timeSetBtn: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!

    
    @IBAction func timeSet(_ sender: AnyObject) {
        timePicker.isHidden = false;
        
    }
    
    

    
    //Function returning a random number from hacksArray.count without being repeateds
    var previousNumber: Int?
    func randomNumber() -> Int {
        var randomNumber = Int(arc4random_uniform(UInt32(hacksArray.count)))
        while previousNumber == randomNumber {
            randomNumber = Int(arc4random_uniform(UInt32(hacksArray.count)))
        }
        previousNumber = Int(randomNumber)
        return randomNumber
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Requests permission from user to
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            if granted{
                print("Notification access granted")
                
            }else{
                print(error?.localizedDescription)
            }
        
        })
    }
    
    @IBAction func notifySwitchOn(_ sender: UISwitch){
        let randomIndex: Int = self.randomNumber()

        scheduledNotification(index: randomIndex, inSeconds: 5, completion: { success in
            if success{
                print("Succesfully scheduled notification")
                //Updates hack label
                self.hackLbl.text = self.hacksArray[randomIndex]
                self.hackLbl.isHidden = false
            }else{
                print("Error scheduling notifcation")
            }})
        }
    
    
    func scheduledNotification(index: Int, inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {

        //Notification
        let notif = UNMutableNotificationContent()
        notif.title = "New Hack!"
        notif.subtitle = "These are great"
        notif.body = self.hacksArray[index]
        
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

