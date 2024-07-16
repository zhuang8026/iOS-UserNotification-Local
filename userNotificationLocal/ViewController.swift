//
//  ViewController.swift
//  userNotificationLocal

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNotification()
    }

    func createNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "打我啊笨蛋"
        content.subtitle = "哈哈"
        content.body = "還敢下來啊冰鳥"
        content.badge = 888
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "alarmMessage"

        let imageURL = Bundle.main.url(forResource: "bird", withExtension: "png")
        let attachment = try! UNNotificationAttachment(identifier: "", url: imageURL!, options: nil)
        
        content.attachments = [attachment]
        
        //Add specific time trigger
//        var date = DateComponents()
//        date.year = 2019
//        date.month = 9
//        date.day = 17
//        date.hour = 12
//        date.minute = 12
//        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}

