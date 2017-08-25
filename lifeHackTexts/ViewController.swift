//
//  ViewController.swift
//  lifeHackTexts
//
//  Created by Felipe Samuel Rodriguez on 10/8/16.
//  Copyright © 2016 Technigraphic. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation
var targetSound: AVAudioPlayer!
var backgroundSound: AVAudioPlayer!


class ViewController: UIViewController {
    
    //Switch for turning on texts
    @IBOutlet weak var hackSwitch: UISwitch!
    
    //Array cointaing daily quotes
    var hacksArray: [String] = ["Always try to go to the zoo when it's colder out than normal. Animals will always be more active trying to stay warm.",
    "Potatoes should be mashed using warm milk only. Cold milk will make your potatoe turn gray.",
    "Take 10 seconds today to write down the serial number of your bycicle. This will help prove its yours if it's ever stolen and shows up on for sale online or at a cop station.",
    "To clear a stuffy nose easily you can push your tongue against roof of mouth, then press finger between eyebrowns. Repeat 20 seconds.",
    "Out of mayonnaise but don't want to fo to the store? Blend together 1 egg with 150ml of olive oil. It works just as good.",
    "Save your PowerPoint presentation as a"+"\" PowerPoint Show\""+" (.ppsx) and it will open directly to the slidesow",
    "People who laugh more are better able to tolerate pain. Both physical and emotional.",
    "By peing in the shower, you can save about 1,157 gallons of water a year.",
    "Use a piece of tape to pick up those last lines of dust that never seem to go in the dust pan.",
    "If someones does a good job for you and you are asked to do a surveym do it. Their compensation may depend on it.",
    "There is a Google Map that shows over 130 airports and their WiFi passwords --> Bit.ly/airportwifimap",
    "Want your carve pumpkin to last longer? Apply some pretroleum Jelly to the cuts. This will extend your pumpkins life big time!",
    "Life Tip: If you have to yell, you already lost the argument.",
    "Listening to music for at least 10 minutes a day strengthens your minds ability to handle stress.",
    "Eat an orage before working out. Not only does it keep you hydrated, but it also prevents your muscles from getting sore.",
    "Have a migraine? Put your hands in ice water and flex them.",
    "Worrying is like a rocking chair. It gives you something to do but it doesn't get you anywhere",
    "Make ice cubes out of liquid they will be going in to like coke, coffe, wine, etc. This will prevent the drink from becoming water down.",
    "People are more likely to return a lost wallet if they find a baby picture inside of it.",
    "Look at someones elbow when you High-Five. You will never miss.",
    "Complete a simple task like making up your bed or preparing a real breakfast when you wake up in the morning. The feeling of even the smallest accomplishment has been proven to make you more productive during the day.",
    "How to make "+"\"cheating\""+" dice: Set oven to 250, lay on cookie sheet with the number you want to always land face up when rolled, and cook for 10 minutes.",
    "Marrying your best friend eliminates the risk of divorce by over 50%. These marriages are more likely to last a lifetime.",
    "If you're always hungry, you are probably just dehydrated. Drink a glass of water.",
    "Each 5MPH you drive over 60MPH is like paying an additional 10 cents a gallon of gas.",
    "Make sure you to go grocery shopping AFTER a meal. You'll always end up sepnding less money.",
    "If you buy a bag of Starbucks coffee and return the bag when empty they will give you a free 12oz coffee.",
    "Writing your fears down before taking an exam can actually help you do better on it.",
    "The ultimate detox water: 1/2 a cucumber, 1 lime slice, 1 sprig of mint leaves, and water.",
    "A recent study showed that a Wednesday is the best day of the week to go out on a first date.",
    "Going through a breakup? Change your text and ringtone sound. Your brain ties a lot of memories to sound."]
    
    var imageArray: [UIImage] = [UIImage(named:"1.png")!, UIImage(named:"2.png")!, UIImage(named:"3.png")!, UIImage(named:"4.png")!, UIImage(named:"5.png")!, UIImage(named:"6.png")!, UIImage(named:"7.png")!, UIImage(named:"8.png")!, UIImage(named:"9.png")!, UIImage(named:"10.png")!, UIImage(named:"11.png")!, UIImage(named:"12.png")!, UIImage(named:"13.png")!, UIImage(named:"14.png")!, UIImage(named:"15.png")!, UIImage(named:"16.png")!, UIImage(named:"17.png")!, UIImage(named:"18.png")!, UIImage(named:"19.png")!, UIImage(named:"20.png")!, UIImage(named:"21.png")!, UIImage(named:"22.png")!, UIImage(named:"23.png")!, UIImage(named:"24.png")!, UIImage(named:"25.png")!, UIImage(named:"26.png")!, UIImage(named:"27.png")!, UIImage(named:"28.png")!, UIImage(named:"29.png")!, UIImage(named:"30.png")!, UIImage(named:"31.png")!]
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    //Hack main label
    @IBOutlet weak var hackLbl: UILabel!
    
    //Button for setting the time
    @IBOutlet weak var timeSetBtn: UIButton!
    
    //timePicker
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var selectedDate: String?
    
    @IBAction func timeSet(_ sender: AnyObject) {
        timePicker.isHidden = false;
        imageIcon.isHidden = true;
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: timePicker.date)
    }
    
    
    //Function returning a random number from hacksArray.count without being repeated
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
        
        }
            
        )
        soundClass.sharedHelper.playBackgroundMusic()
    }
    
    @IBAction func notifySwitchOn(_ sender: UISwitch){
        let randomIndex: Int = self.randomNumber()
        let randomIndex2: Int = self.randomNumber()
        
        
        if self.hackSwitch.isOn{
            scheduledNotification(index: randomIndex, index2: randomIndex2, inSeconds: 5, completion: { success in
                if success{
                    print("Succesfully scheduled notification")
                    
                }else{
                    print("Error scheduling notifcation")
                }})
        }

        }
    

    func scheduledNotification(index: Int, index2: Int, inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        //Notification
        let notif = UNMutableNotificationContent()
        notif.title = "New Hack"
        notif.subtitle = "These are great!"
        notif.body = self.hacksArray[index]
        self.updateHacksView(index: index, index2: index2)
        
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
    
    
    func updateHacksView(index: Int, index2: Int){

        //Updates hack label
        self.hackLbl.isHidden = false
        self.imageIcon.isHidden = false
        hackLbl.text = self.hacksArray[index]
        imageIcon.image = self.imageArray[index2]
        hackLbl.text = self.hacksArray[index]
        //Sound
        UIView.animate(withDuration: 3.0,
                       animations: {self.hackLbl.alpha = 1.0})
        targetSound = try? AVAudioPlayer(contentsOf:URL(fileURLWithPath:Bundle.main.path(forResource: "CoolNot", ofType: "wav")! ))
        targetSound.play()

        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

